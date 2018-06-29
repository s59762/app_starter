class Product::VariantSerializer < ApplicationSerializer
  type 'product_variants'

  attributes :id,
             :name,
             :sku,
             :original_price,
             :sell_price,
             :discounted_price,
             :weight,
             :width,
             :depth,
             :height,
             :is_master,
             :description,
             :product_id

  money_to_integer :original_price,
                   :sell_price,
                   :discounted_price
end
