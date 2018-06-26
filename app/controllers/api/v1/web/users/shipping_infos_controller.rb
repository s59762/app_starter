class Api::V1::Web::Users::ShippingInfosController < Api::V1::Web::BaseController
  before_action :check_data_ownership!

  def index
    user = User.find(params[:user_id])
    shipping_infos = FetchingDataService.call(user.shipping_infos, params)
    result = Api::DataCacheService.call(shipping_infos, request)

    render json: result
  end

  def create
    user = User.find(params[:user_id])
    shipping_info = user.shipping_infos.new
    form = User::ShippingInfoForm.new(shipping_info)

    return raise ValidationFailureException, form unless form.validate(shipping_info_params)

    form.save

    render json: form.model
  end

  def update
    user = User.find(params[:user_id])
    shipping_info = user.shipping_infos.find(params[:id])
    form = User::ShippingInfoForm.new(shipping_info)

    return raise ValidationFailureException, form unless form.validate(shipping_info_params)

    form.save

    render json: form.model
  end

  def destroy
    user = User.find(params[:user_id])
    shipping_info = user.shipping_infos.find(params[:id])

    shipping_info.destroy

    render json: { messages: ['shipping info destroyed succefully.'] }
  end

  private

  def check_data_ownership!
    return if admin_signed_in?

    raise DataOwnershipFailureException, 'User can only access data that belong to self.' if params[:user_id].to_i != current_api_user.id
  end

  def shipping_info_params
    ActiveModelSerializers::Deserialization.jsonapi_parse(params)
  end
end
