class Api::V1::Web::AdminsController < Api::V1::Web::BaseController
  def index
    @admins = query_with_paginate_and_sort_options_for(Admin)

    render json: @admins,
           meta: pagination_dict(@admins).merge({
            lastest_update_at: @admins.order(updated_at: :asc).last.updated_at.to_i
           })
  end

  def show
    @admin = Admin.find(params[:id])

    render json: @admin
  end
end
