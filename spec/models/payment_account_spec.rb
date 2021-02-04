# == Schema Information
#
# Table name: payment_accounts
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  balance    :float            default("0.0"), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_payment_accounts_on_user_id  (user_id)
#

require 'rails_helper'

describe PaymentAccount, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:balance) }
  end
end
