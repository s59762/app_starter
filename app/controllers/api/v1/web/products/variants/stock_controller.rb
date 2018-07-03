class Api::V1::Web::Products::Variants::StockController < Api::V1::Web::BaseController
  def update
    variant = Product::Variant.find(params[:product_variant_id])
    form = Admin::ProductVariantStockForm.new(variant)

    return raise ValidationFailureException, form unless form.validate(stock_params)

    form.save

    render json: form.model
  end

  private

  def stock_params
    ActiveModelSerializers::Deserialization.jsonapi_parse(params)
  end
end
