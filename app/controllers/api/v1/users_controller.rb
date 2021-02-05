module Api
  module V1
    class UsersController < ApiController
      def balance
        @balance = user.payment_account_balance
      end

      def payment
        PaymentService.new(user, receiver, params[:amount], params[:description]).create!

        render json: {}, status: :no_content
      end

      private

      def user
        User.find(params[:id])
      end

      def receiver
        User.find(params[:friend_id])
      end
    end
  end
end
