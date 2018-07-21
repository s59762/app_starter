class Api::V1::Web::Brands::BannersController < Api::V1::Web::BaseController
  def index
    check_policy BrandPolicy.new(current_api_user, :brand).show?

    brand = Brand.find(params[:brand_id])
    banners = FetchingDataService.call(brand.banners, params)
    result = Api::DataCacheService.call(banners, request)

    render json: result
  end

  def create
    check_policy BrandPolicy.new(current_api_user, :brand).create?

    brand = Brand.find(banner_params[:brand_id])
    banner = brand.banners.new
    form = Admin::BrandBannerForm.new(banner)

    return raise ValidationFailureException, form unless form.validate(banner_params)

    form.save

    render json: form.model
  end

  def update
    check_policy BrandPolicy.new(current_api_user, :brand).update?

    brand = Brand.find(banner_params[:brand_id])
    banner = brand.banners.find(params[:id])
    form = Admin::BrandBannerForm.new(banner)

    return raise ValidationFailureException, form unless form.validate(banner_params)

    form.save

    render json: form.model
  end

  def destroy
    check_policy BrandPolicy.new(current_api_user, :brand).update?

    banner = Brand::Banner.find(params[:id])

    banner.destroy

    render json: { messages: ['banner deleted successfully.'] }
  end

  private

  def banner_params
    params.require(:banner).permit(:alt_text, :brand_id, :image)
  end
end
