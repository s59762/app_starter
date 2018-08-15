class Api::V1::Web::Products::VariantsController < Api::V1::Web::BaseController
  def create
    variant = Product.find(variant_params[:product_id]).variants.new
    form = Admin::ProductVariantForm.new(variant)

    return raise ValidationFailureException, form unless form.validate(variant_params)

    form.save

    render json: form.model, serializer: Product::VariantSerializer::Detail
  end

  def update
    variant = Product::Variant.find(params[:id])
    form = Admin::ProductVariantForm.new(variant)

    return raise ValidationFailureException, form unless form.validate(variant_params)

    form.save

    render json: form.model, serializer: Product::VariantSerializer::Detail
  end

  private

  def variant_params
    ActiveModelSerializers::Deserialization.jsonapi_parse(params)
  end
end
