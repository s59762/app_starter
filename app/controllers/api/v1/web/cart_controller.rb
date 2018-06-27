class Api::V1::Web::CartController < Api::V1::Web::BaseController
  def show
    render json: current_cart
  end
end
