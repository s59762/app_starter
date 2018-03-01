class Api::V1::Web::AdminsController < Api::V1::Web::BaseController
  def index
    @admins = Admin.recent.page(page_number).per(page_size)

    render json: @admins,
           meta: { total: @admins.count,
                   lastest_update_at: @admins.order(updated_at: :asc).last.updated_at.to_i }
  end

  def show
    @admin = Admin.find(params[:id])

    render json: @admin
  end
end
