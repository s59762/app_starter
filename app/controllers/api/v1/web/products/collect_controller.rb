class Api::V1::Web::Products::CollectController < Api::V1::Web::BaseController
  def create
    check_policy User::CollectionPolicy.new(current_api_user, :collection).create?, message: 'This is User-Only API'

    if current_api_user.collections.find_by(product_id: params[:product_id])
      render json: { messages: ['product in collections already.'] },
             status: :bad_request
    else
      product = Product.find(params[:product_id])
      current_api_user.collections.create(product: product)

      render json: current_api_user.collections
    end
  end

  def destroy
    check_policy User::CollectionPolicy.new(current_api_user, :collection).index?, message: 'This is User-Only API'

    collection = current_api_user.collections.find_by(product_id: params[:product_id])

    if collection
      check_policy User::CollectionPolicy.new(current_api_user, collection).destroy?

      collection.destroy

      render json: { messages: ['collection destroyed succefully.'] }
    else
      render json: { messages: ['product not in collections yet.'] },
             status: :bad_request
    end
  end
end
