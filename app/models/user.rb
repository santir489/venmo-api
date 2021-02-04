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

class User < ApplicationRecord
  has_many :friendships_a, class_name: 'Friendship', inverse_of: :user_a, dependent: :destroy,
                           foreign_key: :user_a_id

  has_many :friendships_b, class_name: 'Friendship', inverse_of: :user_b, dependent: :destroy,
                           foreign_key: :user_b_id

  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :username, presence: true, uniqueness: { case_sensitive: false }

  def friend_with?(another_user)
    Friendship.where(user_a: self, user_b: another_user)
              .or(Friendship.where(user_a: another_user, user_b: self))
              .exists?
  end
end
