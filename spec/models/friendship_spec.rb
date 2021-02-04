# == Schema Information
#
# Table name: friendships
#
#  id         :integer          not null, primary key
#  user_a_id  :integer          not null
#  user_b_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_friendships_on_user_a_id  (user_a_id)
#  index_friendships_on_user_b_id  (user_b_id)
#

require 'rails_helper'

describe Friendship, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user_a).class_name('User') }
    it { is_expected.to belong_to(:user_b).class_name('User') }
  end

  describe 'validations' do
    describe '#not_friend_with_itself' do
      let!(:user) { create(:user) }

      subject { build(:friendship, user_a: user, user_b: user) }

      it 'is not valid' do
        expect(subject).not_to be_valid
      end

      it 'adds not_friend_with_itself error message' do
        subject.valid?
        error_message = I18n.t('model.friendship.error.not_friend_with_itself')
        expect(subject.errors.messages[:base]).to include(error_message)
      end
    end

    describe '#not_already_friends' do
      let!(:friendship) { create(:friendship) }

      subject do
        build(:friendship, user_a: friendship.user_a, user_b: friendship.user_b)
      end

      it 'is not valid' do
        expect(subject).not_to be_valid
      end

      it 'adds not_already_friends error message' do
        subject.valid?
        error_message = I18n.t('model.friendship.error.not_already_friends')
        expect(subject.errors.messages[:base]).to include(error_message)
      end
    end
  end
end
