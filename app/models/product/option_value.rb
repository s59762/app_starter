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

class Product::OptionValue < ApplicationRecord
  belongs_to :option_type, class_name: 'Product::OptionType', touch: true
end
