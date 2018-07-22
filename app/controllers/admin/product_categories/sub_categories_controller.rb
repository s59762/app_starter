require_dependency 'admin/application_controller'

class Admin::ProductCategories::SubCategoriesController < Admin::ApplicationController
  def show
    @parent_category = ProductCategory.find(params[:product_category_id])
    @product_category = @parent_category.sub_categories.find(params[:id])

    authorize @product_category, :show?
  end
end
