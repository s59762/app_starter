require_dependency 'admin/application_controller'

class Admin::ProductsController < Admin::ApplicationController
  def index
    authorize :product, :index?
    show_flash_message
  end

  def new
    authorize :product, :create?
  end

  def edit
    @product = Product.find(params[:id])

    authorize @product, :update?
  end

  private

  def show_flash_message
    product_added = params[:product_added] && request.referer.split('/')[-2] == 'products' && request.referer.split('/')[-1] == 'new'
    product_updated = params[:product_updated] && request.referer.split('/')[-3] == 'products' && request.referer.split('/')[-1] == 'edit'

    return unless product_added || product_updated

    flash.now[:success] = I18n.t('messages.resource_added_successfully', resource: Product.model_name.human) if product_added
    flash.now[:success] = I18n.t('messages.resource_updated_successfully', resource: Product.model_name.human) if product_updated
  end
end
