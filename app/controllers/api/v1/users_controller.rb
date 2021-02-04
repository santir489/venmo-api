module Api
  module V1
    class UsersController < ApiController
      def balance
        @balance = user.payment_account_balance
      end

      def user
        User.find(params[:id])
      end
    end
  end
end
