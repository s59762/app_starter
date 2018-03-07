class Api::V1::Web::UsersController < Api::V1::Web::BaseController
  def index
    @users = query_with_paginate_and_sort_options_for(User)

    render json: @users,
           meta: pagination_dict(@users)
  end
end
