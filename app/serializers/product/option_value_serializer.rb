class Product::OptionValueSerializer < ApplicationSerializer
  type 'product_option_values'

  attributes :id,
             :value
end
