module Payments
  class NotFriendsError < VenmoError
    def initialize
      super(I18n.t('model.payment.error.users_friendship'))
    end
  end
end
