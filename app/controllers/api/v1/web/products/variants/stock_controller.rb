class Api::V1::Web::Products::Variants::StockController < Api::V1::Web::BaseController
  def update
    variant = Product::Variant.includes(:product).find(params[:product_variant_id])

    check_policy ProductPolicy.new(current_api_user, variant.product).update?

    form = Admin::ProductVariantStockForm.new(variant)

    form.current_admin = current_api_user
    return raise ValidationFailureException, form unless form.validate(stock_params)

    form.save

    render json: form.model
  end

  private

  def stock_params
    ActiveModelSerializers::Deserialization.jsonapi_parse(params)
  end
end
