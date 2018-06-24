class Api::V1::Web::BrandsController < Api::V1::Web::BaseController
  def index
    brands = FetchingDataService.call(Brand, params)
    result = Api::DataCacheService.call(brands, request)

    render json: result
  end

  def show
    brand = Brand.find(params[:id])

    render json: brand
  end

  def create
    brand = Brand.new
    form = Admin::BrandForm.new(brand)

    return raise ValidationFailureException, form unless form.validate(brand_params)

    form.save

    render json: form.model
  end

  def update
    brand = Brand.find(params[:id])
    form = Admin::BrandForm.new(brand)

    return raise ValidationFailureException, form unless form.validate(brand_params)

    form.save

    render json: form.model
  end

  private

  def brand_params
    ActiveModelSerializers::Deserialization.jsonapi_parse(params)
  end
end
