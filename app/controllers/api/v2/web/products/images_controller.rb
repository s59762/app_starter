class Api::V2::Web::Products::ImagesController < ApplicationController
  def create
    product = Product.find(params[:product_id])
    form = AttachmentForm.new(product)

    return raise ValidationFailureException, form unless form.validate(image_params)

    form.save

    render json: form.model, include: ['images'], show_images: true
  end

  def destroy
    product = Product.include(:images).find(params[:product_id])
    image = product.images.find(params[:id])

    image.destroy

    render json: { message: ['image destroyed.'] }
  end

  private

  def image_params
    ActiveModelSerializers::Deserialization.jsonapi_parse(params)
  end
end
