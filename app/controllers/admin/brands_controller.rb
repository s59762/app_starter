require_dependency 'admin/application_controller'

class Admin::BrandsController < Admin::ApplicationController
  def index
    authorize :brand, :index?
  end
end
