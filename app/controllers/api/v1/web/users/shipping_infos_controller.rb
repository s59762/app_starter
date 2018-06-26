class Api::V1::Web::Users::ShippingInfosController < Api::V1::Web::BaseController
  def index
    user = User.find(params[:user_id])

    check_policy User::ShippingInfoPolicy.new(current_api_user, user).index?, message: 'User can only access data that belong to self.'

    shipping_infos = FetchingDataService.call(user.shipping_infos, params)
    result = Api::DataCacheService.call(shipping_infos, request)

    render json: result
  end

  def create
    user = User.find(params[:user_id])

    check_policy User::ShippingInfoPolicy.new(current_api_user, user).create?, message: 'User can only access data that belong to self.'

    shipping_info = user.shipping_infos.new
    form = User::ShippingInfoForm.new(shipping_info)

    return raise ValidationFailureException, form unless form.validate(shipping_info_params)

    form.save

    render json: form.model
  end

  def update
    user = User.find(params[:user_id])
    shipping_info = user.shipping_infos.find(params[:id])

    check_policy User::ShippingInfoPolicy.new(current_api_user, shipping_info).update?, message: 'User can only access data that belong to self.'

    form = User::ShippingInfoForm.new(shipping_info)

    return raise ValidationFailureException, form unless form.validate(shipping_info_params)

    form.save

    render json: form.model
  end

  def destroy
    user = User.find(params[:user_id])
    shipping_info = user.shipping_infos.find(params[:id])

    check_policy User::ShippingInfoPolicy.new(current_api_user, shipping_info).destroy?, message: 'User can only access data that belong to self.'

    shipping_info.destroy

    render json: { messages: ['shipping info destroyed succefully.'] }
  end

  private

  def shipping_info_params
    ActiveModelSerializers::Deserialization.jsonapi_parse(params)
  end
end
