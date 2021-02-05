class FeedService
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def fetch
    friends = friends_up_to_second_degree
    Payment.where(sender_id: friends).or(Payment.where(receiver_id: friends)).distinct
           .order(created_at: :desc).includes(:sender, :receiver)
  end

  private

  def friends_up_to_second_degree
    FriendshipService.new(user).friends_up_to_second_degree
  end
end
