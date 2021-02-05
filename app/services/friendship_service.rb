class FriendshipService
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def friends_up_to_second_degree
    friends = friends_of([user.id])
    friends = friends_of(friends)
    ([user.id] + friends).uniq
  end

  private

  def friends_of(users)
    Friendship.where(user_a_id: users).or(Friendship.where(user_b_id: users))
              .pluck(:user_a_id, :user_b_id).flatten.uniq
  end
end
