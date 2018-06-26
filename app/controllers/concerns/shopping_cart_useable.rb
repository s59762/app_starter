module ShoppingCartUseable
  extend ActiveSupport::Concern

  included do
    before_action :set_cart
  end

  private

  # 產生購物車
  def set_cart
    session[:cart_id] = Cart.create.id unless current_cart
  end

  # 取得當前的購物車
  def current_cart
    @current_cart ||= Cart.find_by(id: session[:cart_id])
  end
end