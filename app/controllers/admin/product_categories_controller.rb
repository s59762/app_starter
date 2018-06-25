require_dependency 'admin/application_controller'

class Admin::ProductCategoriesController < Admin::ApplicationController
  def index
    authorize :product_category, :index?
  end
end
