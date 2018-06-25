require_dependency 'admin/application_controller'

class Admin::AdminsController < Admin::ApplicationController
  def index
    authorize :admin, :index?
  end

  def show
    @admin = Admin.find(params[:id])

    authorize @admin, :show?
  end
end
