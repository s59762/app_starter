class Api::V1::Web::ProductsController < Api::V1::Web::BaseController
  before_action :for_admin_only!, except: %i(index show)

  def index
    check_policy ProductPolicy.new(current_api_user, :product).index?

    products = FetchingDataService.call(Product, params)
    result = Api::DataCacheService.call(products,
                                        request,
                                        extra: product_index_extra_options,
                                        user_scope: current_api_user_scope,
                                        includes: [:brand, :images, master: [:images], option_types: [:option_values], category: [:parent]])

    render json: result
  end

  def show
    product = Product.includes(:brand, variants_with_master: [:images], option_types: [:option_values], category: [:parent]).find(params[:id])

    check_policy ProductPolicy.new(current_api_user, product).show?

    render json: product,
           include: [:images, :variants_with_master, 'option_types.option_values'],
           show_variants: true,
           show_options: true,
           show_images: true,
           serializer: signed_in_as?('Admin') ? ProductSerializer::Detail : ProductSerializer
  end

  def create
    product = Product.new
    form = Admin::NewProductForm.new(product)

    check_policy ProductPolicy.new(current_api_user, :product).create?

    return raise ValidationFailureException, form unless form.validate(product_params)

    form.save

    render json: form.model,
           include: [:images, :variants_with_master, 'option_types.option_values'],
           show_variants: true,
           show_options: true,
           show_images: true
  end

  def update
    product = Product.includes(variants_with_master: [:images], option_types: [:option_values]).find(params[:id])
    form = Admin::EditProductForm.new(product)

    check_policy ProductPolicy.new(current_api_user, product).update?

    return raise ValidationFailureException, form unless form.validate(product_params)

    form.save

    render json: form.model,
           include: [:images, :variants_with_master, 'option_types.option_values'],
           show_variants: true,
           show_options: true,
           show_images: true
  end

  private

  def product_params
    ActiveModelSerializers::Deserialization.jsonapi_parse(params)
  end
end
