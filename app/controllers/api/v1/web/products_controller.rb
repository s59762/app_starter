class Api::V1::Web::ProductsController < Api::V1::Web::BaseController
  before_action :for_admin_only!, except: %i(show)

  def index
    @products = FetchingDataService.call(Product, params)

    render json: @products
  end

  def show
    @product = Product.find(params[:id])

    render json: @product
  end

  def create
    form = Admin::ProductForm.new(Product.new)

    return raise ValidationFailureException, form unless form.validate(product_params)

    form.save

    render json: form.model
  end

  def update
    form = Admin::ProductForm.new(Product.find(params[:id]))

    return raise ValidationFailureException, form unless form.validate(product_params)

    form.save

    render json: form.model
  end

  private

  def product_params
    ActiveModelSerializers::Deserialization.jsonapi_parse(params)
  end
end
