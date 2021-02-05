class PaymentService
  attr_reader :sender, :receiver, :amount, :description

  def initialize(sender, receiver, amount, description)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @description = description
  end

  def create!
    validate_friendship!

    ActiveRecord::Base.transaction do
      payment = create_payment
      PaymentAccountService.new(payment.sender_payment_account).decrease!(payment.amount)
      PaymentAccountService.new(payment.receiver_payment_account).increase!(payment.amount)
    end
  end

  private

  def validate_friendship!
    return if sender.friend_with?(receiver)

    raise Payments::NotFriendsError
  end

  def create_payment
    Payment.create!(
      sender: sender,
      receiver: receiver,
      amount: amount,
      description: description
    )
  end
end
