class Api::V1::Web::Products::Images::AssignToVariantController < Api::V1::Web::BaseController
  def update
    image = Product::Image.find(params[:product_image_id])
    variant = image.product.variants_with_master.find_by(id: image_params[:variant_id])

    check_policy ProductPolicy.new(current_api_user, :product).create?

    image.update variant: variant

    render json: image
  end

  private

  def image_params
    ActiveModelSerializers::Deserialization.jsonapi_parse(params)
  end
end
