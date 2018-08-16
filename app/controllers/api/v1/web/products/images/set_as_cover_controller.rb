class Api::V1::Web::Products::Images::SetAsCoverController < Api::V1::Web::BaseController
  def update
    image = Product::Image.includes(:product).find(params[:product_image_id])

    check_policy ProductPolicy.new(current_api_user, image.product).update?

    image.set_as_cover

    render json: image.product.images.includes(:product)
  end
end
