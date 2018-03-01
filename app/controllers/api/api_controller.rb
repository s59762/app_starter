class Api::ApiController < ActionController::API
  include Api::ExceptionHandleable

  before_action :set_default_format

  def set_default_format
    request.format = :json
  end
end
