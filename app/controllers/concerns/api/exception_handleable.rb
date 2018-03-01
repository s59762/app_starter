# 提供 API 發生例外時顯示錯誤訊息的功能

module Api
  module ExceptionHandleable
    extend ActiveSupport::Concern

    included do
      rescue_from ActiveRecord::RecordNotFound, with: :not_found
      rescue_from ::ApplicationException, with: :show_exception
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
  end
end
