class Api::V1::Web::ProductCategoriesController < Api::V1::Web::BaseController
  def index
    @categories = FetchingDataService.call(ProductCategory, params).includes(:parent, :sub_categories)

    render json: @categories,
           show_sub_categories: true
  end

  def create
    form = Admin::ProductCategoryForm.new(ProductCategory.new)

    return raise ValidationFailureException, form unless form.validate(product_category_params)

    form.save

    render json: form.model,
           show_sub_categories: true
  end

  def update
    form = Admin::ProductCategoryForm.new(ProductCategory.find(params[:id]))

    return raise ValidationFailureException, form unless form.validate(product_category_params)

    form.save

    render json: form.model,
           show_sub_categories: true
  end

  private

  def product_category_params
    ActiveModelSerializers::Deserialization.jsonapi_parse(params)
  end
end