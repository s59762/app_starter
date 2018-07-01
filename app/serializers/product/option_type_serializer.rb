class Product::OptionTypeSerializer < ApplicationSerializer
  type 'product_option_types'

  attributes :id,
             :name,
             :product_id

  has_many :option_values
end
