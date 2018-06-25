require_dependency 'admin/application_controller'

class Admin::ProductsController < Admin::ApplicationController
  def index
    authorize :product, :index?
  end

  def new
    authorize :product, :create?
  end

  def edit
    @product = Product.find(params[:id])

    authorize @product, :update?
  end
end
