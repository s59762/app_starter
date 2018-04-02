class ProductSerializer < ApplicationSerializer
  attributes :id,
             :category,
             :cover,
             :description,
             :discounted_price,
             :images,
             :is_preorder,
             :name,
             :original_price,
             :properties,
             :sell_price,
             :created_at,
             :discount_rate

  belongs_to :category, class_name: 'ProductCategory', optional: true

  to_unix_time :created_at

  # 折扣率
  def discount_rate
    return nil unless object.discounted_price.present?

    object.discounted_price / object.sell_price
  end
end
