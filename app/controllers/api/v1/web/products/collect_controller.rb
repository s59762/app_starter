class Api::V1::Web::Products::CollectController < Api::V1::Web::BaseController
  def create
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
    collection = current_api_user.collections.find_by(product_id: params[:product_id])

    if collection
      collection.destroy

      render json: { messages: ['collection destroyed succefully.'] }
    else
      render json: { messages: ['product not in collections yet.'] },
             status: :bad_request
    end
  end
end
