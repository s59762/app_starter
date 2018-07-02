# == Schema Information
#
# Table name: product_option_values
#
#  id             :bigint(8)        not null, primary key
#  value          :string
#  option_type_id :bigint(8)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

class Product::OptionValueSerializer < ApplicationSerializer
  type 'product_option_values'

  attributes :id,
             :value,
             :option_type_id
end
