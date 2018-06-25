require_dependency 'admin/application_controller'

class Admin::AdminsController < Admin::ApplicationController
  def index
    authorize :admin, :index?
  end

  def show; end
end
