class Api::V1::Web::ProductsController < Api::V1::Web::BaseController
  before_action :for_admin_only!, except: %i(index show)

  def index
    check_policy ProductPolicy.new(current_api_user, :product).index?

    products = FetchingDataService.call(Product, params).includes(:brand, :category)
    result = Api::DataCacheService.call(products, request)

    render json: result
  end

  def show
    product = Product.find(params[:id])

    check_policy ProductPolicy.new(current_api_user, product).show?

    render json: product,
           include: [:normal_images]
  end

  def create
    product = Product.new
    form = Admin::ProductForm.new(product)

    check_policy ProductPolicy.new(current_api_user, :product).create?

    return raise ValidationFailureException, form unless form.validate(product_params)

    form.save

    render json: form.model
  end

  def update
    product = Product.find(params[:id])
    form = Admin::ProductForm.new(product)

    check_policy ProductPolicy.new(current_api_user, product).update?

    return raise ValidationFailureException, form unless form.validate(product_params)

    form.save

    render json: form.model
  end

  private

  def product_params
    ActiveModelSerializers::Deserialization.jsonapi_parse(params)
  end
end
