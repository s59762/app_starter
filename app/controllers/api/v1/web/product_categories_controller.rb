class Api::V1::Web::ProductCategoriesController < Api::V1::Web::BaseController
  def index
    check_policy ProductCategoryPolicy.new(current_api_user, :category).index?

    categories = FetchingDataService.call(ProductCategory.top_level_only, params)
    result = Api::DataCacheService.call(categories,
                                        request,
                                        extra: {
                                          show_sub_categories: true,
                                          include: [:sub_categories]
                                        },
                                        includes: [:parent, sub_categories: [:parent, :sub_categories]])

    render json: result
  end

  def create
    category = ProductCategory.new
    form = Admin::ProductCategoryForm.new(category)

    check_policy ProductCategoryPolicy.new(current_api_user, category).create?

    return raise ValidationFailureException, form unless form.validate(product_category_params)

    form.save

    render json: form.model
  end

  def update
    category = ProductCategory.find(params[:id])
    form = Admin::ProductCategoryForm.new(category)

    check_policy ProductCategoryPolicy.new(current_api_user, category).update?

    return raise ValidationFailureException, form unless form.validate(product_category_params)

    form.save

    render json: form.model
  end

  private

  def product_category_params
    ActiveModelSerializers::Deserialization.jsonapi_parse(params)
  end
end
