class Api::V1::Web::BannersController < Api::V1::Web::BaseController
  def index
    # check_policy AdminPolicy.new(current_api_user, :admin).index?

    banners = FetchingDataService.call(Banner, params).order(position: :asc)
    result = Api::DataCacheService.call(banners, request)

    render json: result
  end

  def create
    banner = Banner.new

    form = Admin::BannerForm.new(banner)

    return raise ValidationFailureException, form unless form.validate(banner_params)

    form.save

    render json: form.model
  end

  def update
    banner = Banner.find(params[:id])
    form = Admin::BannerForm.new(banner)

    return raise ValidationFailureException, form unless form.validate(banner_params)

    form.save

    render json: form.model
  end

  def destroy
    banner = Banner.find(params[:id])

    banner.destroy

    render json: { messages: ['banner deleted successfully.'] }
  end

  private

  def banner_params
    params.require(:banner).permit(:alt_text, :use_type, :image)
  end
end
