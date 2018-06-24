class Api::V1::Web::Users::CollectionsController < Api::V1::Web::BaseController
  def index
    # TODO: this API is for User only
    collections = FetchingDataService.call(current_api_user.collections, params)
    result = Api::DataCacheService.call(collections, request)

    render json: result
  end

  def destroy
    # TODO: this API is for User only
    collection = current_api_user.collections.find(params[:id])

    collection.destroy

    render json: { messages: ['collection destroyed succefully.'] }
  end
end
