class Api::V1::Web::AdminsController < Api::V1::Web::BaseController
  def index
    if params[:sort].present?
      @admins = params[:sort][0] == '-' ? Admin.page(page_number).per(page_size).order("#{params[:sort][1..-1]} DESC") : Admin.page(page_number).per(page_size).order("#{params[:sort][0..-1]} ASC")
    else
      @admins = Admin.recent.page(page_number).per(page_size)
    end

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
