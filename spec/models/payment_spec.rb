# == Schema Information
#
# Table name: payments
#
#  id          :integer          not null, primary key
#  sender_id   :integer          not null
#  receiver_id :integer          not null
#  amount      :float            default("0.0"), not null
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_payments_on_receiver_id  (receiver_id)
#  index_payments_on_sender_id    (sender_id)
#

require 'rails_helper'

describe Payment, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:receiver).class_name('User') }
    it { is_expected.to belong_to(:sender).class_name('User') }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:amount) }
    it do
      is_expected.to validate_numericality_of(:amount).is_greater_than(0).is_less_than(1_000)
    end

    describe '#users_friendship' do
      let(:sender) { create(:user) }
      let(:receiver) { create(:user) }

      subject { build(:payment, sender: sender, receiver: receiver) }

      context 'when sender and receiver are not friends' do
        it 'is not valid' do
          expect(subject).not_to be_valid
        end

        it 'adds users_friendship error message' do
          subject.valid?
          error_message = I18n.t('model.payment.error.users_friendship')
          expect(subject.errors.messages[:base]).to include(error_message)
        end
      end

      context 'when sender and receiver are friends' do
        let!(:friendship) { create(:friendship, user_a: sender, user_b: receiver) }

        it 'is valid' do
          expect(subject).to be_valid
        end
      end
    end
  end
end
