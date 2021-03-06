class Api::V1::Web::Users::CollectionsController < Api::V1::Web::BaseController
  def index
    check_policy User::CollectionPolicy.new(current_api_user, :collection).index?, message: 'This is User-Only API'

    collections = FetchingDataService.call(current_api_user.collections, params)
    result = Api::DataCacheService.call(collections, request)

    render json: result
  end

  def destroy
    check_policy User::CollectionPolicy.new(current_api_user, :collection).index?, message: 'This is User-Only API'

    collection = current_api_user.collections.find(params[:id])

    check_policy User::CollectionPolicy.new(current_api_user, collection).destroy?

    collection.destroy

    render json: { messages: ['collection destroyed succefully.'] }
  end
end
