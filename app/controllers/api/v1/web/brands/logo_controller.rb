class Api::V1::Web::Brands::LogoController < Api::V1::Web::BaseController
  def update
    brand = Brand.find(params[:brand_id])
    form = Admin::BrandLogoForm.new(brand)

    return raise ValidationFailureException, form unless form.validate(brand_logo_params)

    form.save

    render json: form.model
  end

  private

  def brand_logo_params
    params.require(:brand).permit(:logo)
  end
end
