class Api::V1::Web::Products::OptionValuesController < Api::V1::Web::BaseController
  def create
    check_policy ProductPolicy.new(current_api_user, :product).create?

    option_value = Product::OptionType.find(option_value_params[:option_type_id]).option_values.new
    form = Admin::ProductOptionValueForm.new(option_value)

    return raise ValidationFailureException, form unless form.validate(option_value_params)

    form.save

    render json: form.model
  end

  def update
    option_value = Product::OptionValue.includes(option_type: :product).find(params[:id])

    check_policy ProductPolicy.new(current_api_user, option_value.option_type.product).update?

    form = Admin::ProductOptionValueForm.new(option_value)

    return raise ValidationFailureException, form unless form.validate(option_value_params)

    form.save

    render json: form.model
  end

  private

  def option_value_params
    ActiveModelSerializers::Deserialization.jsonapi_parse(params)
  end
end
