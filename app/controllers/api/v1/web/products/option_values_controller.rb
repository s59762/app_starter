class Api::V1::Web::Products::OptionValuesController < Api::V1::Web::BaseController
  def update
    option_value = Product::OptionValue.find(params[:id])
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
