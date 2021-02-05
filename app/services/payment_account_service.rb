class PaymentAccountService
  attr_reader :account

  def initialize(account)
    @account = account
  end

  def increase!(amount)
    return unless amount.positive?

    balance = account.balance
    account.update!(balance: balance + amount)
  end

  def decrease!(amount)
    return unless amount.positive?

    balance = account.balance

    if amount > balance
      MoneyTransferService.new(Object.new, account).transfer(amount - balance)
      new_balance = 0
    else
      new_balance = balance - amount
    end

    account.update!(balance: new_balance)
  end
end
