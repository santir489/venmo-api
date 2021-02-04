require 'rails_helper'

describe 'get api/v1/user/:id/balance', type: :request do
  let!(:user) { create(:user) }
  let(:balance) { Faker::Number.within(range: 1..999) }

  before do
    user.payment_account.update!(balance: balance)
    get balance_api_v1_user_path(id: user_id), as: :json
  end

  context 'when the request is valid' do
    let(:user_id) { user.id }

    it 'returns successful response' do
      expect(response).to be_successful
    end

    it 'returns user balance' do
      expect(json[:user][:balance]).to eq(balance)
    end
  end

  context 'when the request is not valid' do
    let(:user_id) { 'invalid_id' }

    it 'returns not_found response' do
      expect(response).to have_http_status(:not_found)
    end
  end
end
