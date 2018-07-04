class Api::V1::Web::Products::Images::SetAsCoverController < Api::V1::Web::BaseController
  def update
    image = Product::Image.find(params[:product_image_id])

    check_policy ProductPolicy.new(current_api_user, :product).create?

    image.set_as_cover

    render json: image.product.normal_images.includes(:product)
  end
end
