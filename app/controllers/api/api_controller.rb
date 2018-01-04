class Api::ApiController < ActionController::API
  before_action :set_default_format
  before_action :authenticate_for_jwt

  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from ::ApplicationException, with: :show_exception

  def set_default_format
    request.format = :json
  end

  private

  def current_api_user
    @current_api_user ||= @api_auth.call
  end

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

  def authenticate_for_jwt
    @api_auth = ApiAuthServiceService.new(request.headers['Authorization'])
  end
end
