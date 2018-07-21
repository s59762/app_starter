class Api::V1::Web::Brands::ProductsController < Api::V1::Web::BaseController
  def index
    check_policy ProductPolicy.new(current_api_user, :product).index?

    brand = Brand.find(params[:brand_id])
    products = FetchingDataService.call(brand.products, params)
    result = Api::DataCacheService.call(products,
                                        request,
                                        extra: product_index_extra_options,
                                        user_scope: current_api_user_scope,
                                        includes: [:images, master: [:images], option_types: [:option_values], category: [:parent]])

    render json: result
  end
end
