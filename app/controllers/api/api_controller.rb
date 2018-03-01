class Api::ApiController < ActionController::API
  before_action :set_default_format

  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ::ApplicationException, with: :show_exception

  def set_default_format
    request.format = :json
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
