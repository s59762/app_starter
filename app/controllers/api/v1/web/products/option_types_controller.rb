class Api::V1::Web::Products::OptionTypesController < Api::V1::Web::BaseController
  def update
    option_type = Product::OptionType.find(params[:id])
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
