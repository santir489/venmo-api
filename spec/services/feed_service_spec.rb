require 'rails_helper'

describe FeedService, type: :service do
  describe '#fetch' do
    let(:user) { create(:user) }

    let!(:friendship1) { create(:friendship, user_a: user) }
    let!(:friendship2) { create(:friendship, user_a: user) }
    let!(:friendship_second_degree1) do
      create(:friendship, user_a: friendship1.user_b)
    end

    let!(:payment1) do
      create(:payment, sender: user, receiver: friendship1.user_b)
    end
    let!(:payment2) do
      create(:payment, sender: user, receiver: friendship2.user_b)
    end
    let!(:payment3) do
      create(:payment, receiver: friendship_second_degree1.user_b)
    end
    let!(:another_payment) { create(:payment) }

    subject { described_class.new(user).fetch }

    it "returns friend's payments" do
      expected_payments = [payment3, payment2, payment1]
      expect(subject).to eq(expected_payments)
    end
  end
end
