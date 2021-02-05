class PaymentDecorator < ApplicationDecorator
  delegate_all

  def message
    I18n.t('model.payment.message', sender: sender_username,
                                    receiver: receiver_username,
                                    time: formatted_date,
                                    description: description)
  end

  private

  def formatted_date
    created_at.strftime('%B %d, %Y')
  end
end
