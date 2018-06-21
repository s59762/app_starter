require_dependency 'admin/application_controller'

class Admin::ProductsController < Admin::ApplicationController
  def index
  end

  def new
  end

  def edit
    @product = Product.find(params[:id])
  end
end
