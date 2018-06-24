class Api::V1::Web::UsersController < Api::V1::Web::BaseController
  before_action :for_admin_only!, except: %i(show)

  def index
    users = FetchingDataService.call(User, params)
    result = Api::DataCacheService.call(users, request)

    render json: result
  end
end
