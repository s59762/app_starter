class Api::V1::Web::Products::OptionTypesController < Api::V1::Web::BaseController
  def create
    check_policy ProductPolicy.new(current_api_user, :product).create?

    option_type = Product.find(option_type_params[:product_id]).option_types.new
    form = Admin::ProductOptionTypeForm.new(option_type)

    return raise ValidationFailureException, form unless form.validate(option_type_params)

    form.save

    render json: form.model
  end

  def update
    option_type = Product::OptionType.includes(:product).find(params[:id])

    check_policy ProductPolicy.new(current_api_user, option_type.product).update?

    form = Admin::ProductOptionTypeForm.new(option_type)

    return raise ValidationFailureException, form unless form.validate(option_type_params)

    form.save

    render json: form.model
  end

  private

  def option_type_params
    ActiveModelSerializers::Deserialization.jsonapi_parse(params)
  end
end
