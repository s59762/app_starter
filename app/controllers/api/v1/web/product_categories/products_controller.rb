class Api::V1::Web::ProductCategories::ProductsController < Api::V1::Web::BaseController
  def index
    category = ProductCategory.find(params[:product_category_id])

    check_policy ProductCategoryPolicy.new(current_api_user, category).show?

    products = FetchingDataService.call(category.products, params)
    result = Api::DataCacheService.call(products,
                                        request,
                                        extra: product_index_extra_options,
                                        user_scope: current_api_user_scope,
                                        includes: [:brand, :images, master: [:images], option_types: [:option_values], category: [:parent]])

    render json: result
  end
end
