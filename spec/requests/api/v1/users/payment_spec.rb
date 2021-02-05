require 'rails_helper'

describe 'get api/v1/user/:id/payment', type: :request do
  let!(:user) { create(:user) }
  let!(:friend) { create(:user) }

  let(:user_id) { user.id }
  let(:friend_id) { friend.id }
  let(:amount) { Faker::Number.within(range: 1..999) }
  let(:description) { Faker::Lorem.words(number: (0..20)) }
  let(:params) do
    {
      friend_id: friend_id,
      amount: amount,
      description: description
    }
  end

  subject do
    post payment_api_v1_user_path(id: user_id), params: params, as: :json
  end

  context 'when the request is not valid' do
    context 'when user_id is not valid' do
      let(:user_id) { 'invalid_id' }

      it 'returns not_found response' do
        subject
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'when friend_id is not valid' do
      let(:friend_id) { 'invalid_id' }

      it 'returns not_found response' do
        subject
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'when users are not friends' do
      it 'returns bad_request response' do
        subject
        expect(response).to have_http_status(:bad_request)
      end

      it 'returns not friend error message' do
        subject
        expect(json[:error]).to eq(I18n.t('model.payment.error.users_friendship'))
      end
    end

    context 'when amount param is missing' do
      let!(:friendship) { create(:friendship, user_a: user, user_b: friend) }
      let(:amount) { nil }

      it 'returns bad_request response' do
        subject
        expect(response).to have_http_status(:bad_request)
      end

      it 'returns can not be blank error message' do
        subject
        expect(json[:error][:amount]).to include("can't be blank")
      end
    end
  end

  context 'when the request is valid' do
    let!(:friendship) { create(:friendship, user_a: user, user_b: friend) }

    before do
      user.payment_account.update!(balance: amount)
    end

    it 'returns successful response' do
      subject
      expect(response).to be_successful
    end

    it 'decreases user balance' do
      subject
      expect(user.reload.payment_account_balance).to eq(0)
    end

    it 'increases friend balance' do
      subject
      expect(friend.reload.payment_account_balance).to eq(amount)
    end

    it 'creates Payment' do
      expect { subject }.to change(Payment, :count).by(1)
    end
  end
end
