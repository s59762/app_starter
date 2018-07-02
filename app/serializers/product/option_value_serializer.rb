class Product::OptionValueSerializer < ApplicationSerializer
  type 'product_option_values'

  attributes :id,
             :value,
             :option_type_id
end
