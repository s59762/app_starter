# 提供 API 發生例外時顯示錯誤訊息的功能

module Api
  module ExceptionHandleable
    extend ActiveSupport::Concern

    included do
      rescue_from ActiveRecord::RecordNotFound, with: :not_found
      rescue_from ::ApplicationException, with: :show_exception
      rescue_from AuthenticateFailureException, with: :logout_current_api_user
    end

    private

    def not_found
      render json: {
        messages: [
          'resources not found'
        ]
      }, status: :not_found
    end

    def show_exception(exception)
      render json: exception.response, status: exception.status
    end

    def logout_current_api_user(exception)
      if request.referer.split('/')[3] == 'admin'
        sign_out(current_admin) if admin_signed_in?
      else
        sign_out(current_user) if user_signed_in?
      end

      render json: exception.response, status: exception.status
    end

  end
end
