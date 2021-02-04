# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  username   :text             not null
#  email      :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_users_on_email     (email) UNIQUE
#  index_users_on_username  (username) UNIQUE
#

require 'rails_helper'

describe User, type: :model do
  describe 'validations' do
    subject { build :user }
    it { is_expected.to validate_uniqueness_of(:username).case_insensitive }
    it { is_expected.to validate_presence_of(:username) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to allow_value('example@mail.com').for(:email) }
    it { is_expected.not_to allow_value('example').for(:email) }
  end

  describe '#friend_with?' do
    let!(:user_a) { create(:user) }
    let!(:user_b) { create(:user) }

    subject { user_a.friend_with?(user_b) }

    context 'when user_a is not friend with user_b' do
      it 'returns false' do
        expect(subject).to be_falsey
      end
    end

    context 'when user_a is friend with user_b' do
      let!(:friendship) do
        create(:friendship, user_a: user_a, user_b: user_b)
      end

      it 'returns true' do
        expect(subject).to be_truthy
      end
    end
  end

  describe 'after_create' do
    subject { create(:user) }

    it 'creates a payment account' do
      expect { subject }.to change(PaymentAccount, :count).by(1)
    end
  end
end
