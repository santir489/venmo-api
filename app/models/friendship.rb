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

class Friendship < ApplicationRecord
  belongs_to :user_a, class_name: 'User'
  belongs_to :user_b, class_name: 'User'

  validate :not_friend_with_itself, :not_already_friends

  private

  def not_friend_with_itself
    return unless user_a == user_b

    errors.add(:base, I18n.t('model.friendship.error.not_friend_with_itself'))
  end

  def not_already_friends
    return unless user_a&.friend_with?(user_b)

    errors.add(:base, I18n.t('model.friendship.error.not_already_friends'))
  end
end
