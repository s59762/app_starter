class Api::ApiController < ActionController::API
  before_action :set_default_format

  def set_default_format
    request.format = :json
  end

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  private

  def not_found
    render json: {
      messages: [
        'resources not found'
      ]
    }, status: :not_found
  end
end
