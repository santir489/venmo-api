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
  end
end
