class Api::V1::Web::ProductsController < Api::V1::Web::BaseController
  def index
    @products = FetchingDataService.call(Product, params)

    render json: @products
  end
end
