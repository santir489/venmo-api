module Api
  module V1
    class ApiController < ApplicationController
      rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

      def render_not_found(exception)
        logger.info(exception) # for logging
        render json: { error: I18n.t('api.error.not_found') }, status: :not_found
      end
    end
  end
end
