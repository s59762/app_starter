class Api::V1::AdminsController < Api::ApiController
  def index
    @admins = Admin.recent

    render json: @admins, meta: { total: @admins.count,
                                  lastest_update_at: @admins.order(updated_at: :asc).last.updated_at.to_i },
           links: { self: api_v1_admins_path }
  end

  def show
    @admin = Admin.find(params[:id])

    render json: @admin
  end
end
