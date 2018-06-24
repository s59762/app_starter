class Api::V1::Web::Users::CollectionsController < Api::V1::Web::BaseController
  def index
    collections = FetchingDataService.call(current_api_user.collections, params)
    result = Api::DataCacheService.call(collections, request)

    render json: result
  end

  def destroy
    collection = current_api_user.collections.find(params[:id])

    collection.destroy

    render json: { messages: ['collection destroyed succefully.'] }
  end
end
