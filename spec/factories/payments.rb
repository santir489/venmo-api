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

FactoryBot.define do
  factory :payment do
    sender      factory: :user
    receiver    factory: :user
    amount      { Faker::Number.within(range: 1..999) }
    description { Faker::Lorem.words(number: (0..20)) }

    before(:create) do |payment|
      create(:friendship, user_a: payment.sender, user_b: payment.receiver)
    end
  end
end
