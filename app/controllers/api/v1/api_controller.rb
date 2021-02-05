module Api
  module V1
    class ApiController < ApplicationController
      rescue_from Exception,                    with: :render_error
      rescue_from Exceptions::NotFriend,        with: :render_not_friend_error
      rescue_from ActiveRecord::RecordInvalid,  with: :render_record_invalid
      rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

      private

      def render_error(exception)
        logger.error(exception)

        render json: { error: I18n.t('api.error.server') }, status: :internal_server_error
      end

      def render_not_found(exception)
        logger.info(exception) # for logging
        render json: { error: I18n.t('api.error.not_found') }, status: :not_found
      end

      def render_record_invalid(exception)
        logger.info(exception) # for logging
        render json: { error: exception.record.errors.as_json }, status: :bad_request
      end

      def render_not_friend_error(exception)
        logger.info(exception) # for logging
        render json: { error: exception.message }, status: :bad_request
      end
    end
  end
end
