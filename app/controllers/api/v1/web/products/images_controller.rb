class Api::V1::Web::Products::ImagesController < Api::V1::Web::BaseController
  def create
    form = Admin::ProductImageForm.new(Product::Image.new)

    return raise ValidationFailureException, form unless form.validate(image_params)

    form.save
    created_images = Product::Image.where(id: form.created_image_ids)

    render json: created_images
  end

  private

  def image_params
    params.require(:product).permit(:use_case, images: [])
  end
end
