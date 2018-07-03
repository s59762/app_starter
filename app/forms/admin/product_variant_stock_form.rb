class Admin::ProductVariantStockForm < ApplicationForm
  VALID_ACTION_ATTRIBUTES = %w(increase decrease).freeze

  model Product::Variant

  property :quantity, virtual: true
  property :action, virtual: true
  property :reason, virtual: true
  property :current_admin_id, virtual: true

  validates :quantity,
            :current_admin_id, presence: true
  validates :quantity, numericality: { greater_than: 0 }
  validate :valid_action?

  def save
    ::ActiveRecord::Base.transaction do
      model.update stock: model.stock + normalized_quantity
      # TODO: create record with reason and current_admin
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
