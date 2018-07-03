class Admin::ProductVariantStockForm < ApplicationForm
  VALID_ACTION_ATTRIBUTES = %w(increase decrease).freeze

  model Product::Variant

  property :quantity, virtual: true
  property :action, virtual: true
  property :reason, virtual: true
  property :current_admin, virtual: true

  validates :quantity, presence: true
  validates :quantity, numericality: { greater_than: 0 }
  validate :valid_action?

  def save
    ::ActiveRecord::Base.transaction do
      model.update stock: model.stock + normalized_quantity
      model.product.create_activity key: "#{action}_stock",
                                    owner: current_admin,
                                    params: {
                                      quantity: quantity,
                                      variant_id: model.id,
                                      reason: reason
                                    }
    end
  end

  def valid_action?
    errors.add(:action, :invalid) unless VALID_ACTION_ATTRIBUTES.include?(action)
  end

  private

  def normalized_quantity
    return -(quantity) if action == VALID_ACTION_ATTRIBUTES.last
    quantity
  end
end
