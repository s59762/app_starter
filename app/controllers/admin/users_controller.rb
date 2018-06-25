require_dependency 'admin/application_controller'

class Admin::UsersController < Admin::ApplicationController
  def index
    authorize :user, :index?
  end
end
