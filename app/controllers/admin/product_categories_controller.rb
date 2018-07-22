require_dependency 'admin/application_controller'

class Admin::ProductCategoriesController < Admin::ApplicationController
  def index
    authorize :product_category, :index?
  end

  def show
    @product_category = ProductCategory.find(params[:id])

    authorize @product_category, :show?
  end
end
