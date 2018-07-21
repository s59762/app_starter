require_dependency 'admin/application_controller'

class Admin::BrandsController < Admin::ApplicationController
  def index
    authorize :brand, :index?
  end

  def show
    @brand = Brand.find(params[:id])

    authorize @brand, :show?
  end
end
