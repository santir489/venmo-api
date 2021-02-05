require 'rails_helper'

describe 'GET /api/v1/user/:id/feed', type: :request do
  let(:user) { create(:user) }
  let(:user_id) { user.id }
  let(:params) { {} }

  subject do
    get feed_api_v1_user_path(id: user_id), params: params
  end

  context 'when the request is not valid' do
    let(:user_id) { 'invalid_id' }

    it 'returns not_found response' do
      subject
      expect(response).to have_http_status(:not_found)
    end
  end

  context 'when the request is valid' do
    let!(:payment) { create(:payment) }

    context 'when user has no activity' do
      it 'returns successful response' do
        subject
        expect(response).to be_successful
      end

      it 'returns successful response' do
        subject
        expect(json[:payments]).to be_empty
      end
    end

    context 'when user has activity' do
      let(:friend1) { create(:user) }
      let(:friend2) { create(:user) }

      let!(:frienship1) { create(:friendship, user_a: user, user_b: friend1) }
      let!(:frienship2) { create(:friendship, user_a: user, user_b: friend2) }

      let!(:payment1) { create(:payment, sender: user, receiver: friend1) }
      let!(:payment2) { create(:payment, sender: friend2, receiver: user) }

      it 'returns payments' do
        subject
        expected_response = [
          {
            id: payment2.id,
            message: payment2.decorate.message
          },
          {
            id: payment1.id,
            message: payment1.decorate.message
          }
        ]
        expect(json[:payments]).to match_array(expected_response)
      end
    end
  end

  describe 'pagination' do
    let!(:frienship) { create(:friendship, user_a: user) }
    let!(:payments) { create_list(:payment, 15, sender: user, receiver: frienship.user_b) }

    context 'when page param is missing' do
      it 'returns first page' do
        subject
        expect(json[:payments].pluck(:id)).to eq(Payment.last(10).reverse.pluck(:id))
      end

      it 'returns actual page' do
        subject
        expect(json[:pagy][:page]).to eq(1)
      end

      it 'returns last page number' do
        subject
        expect(json[:pagy][:last]).to eq(2)
      end
    end

    context 'when page param is 1' do
      let(:params) { { page: 1 } }

      it 'returns first page' do
        subject
        expect(json[:payments].pluck(:id)).to eq(Payment.last(10).reverse.pluck(:id))
      end
    end

    context 'when page param is 2' do
      let(:params) { { page: 2 } }

      it 'returns second page' do
        subject
        expect(json[:payments].pluck(:id)).to eq(Payment.first(5).reverse.pluck(:id))
      end
    end

    context 'when page param is overflow' do
      let(:params) { { page: 20 } }

      it 'returns last page' do
        subject
        expect(json[:payments].pluck(:id)).to eq(Payment.first(5).reverse.pluck(:id))
      end
    end
  end
end
