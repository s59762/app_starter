class Api::V1::Web::UsersController < Api::V1::Web::BaseController
  def index
    @users = FetchingDataService.new(User, params).call

    render json: @users,
           meta: pagination_dict(@users)
  end
end