# == Schema Information
#
# Table name: product_option_types
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  product_id :bigint(8)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Product::OptionTypeSerializer < ApplicationSerializer
  type 'product_option_types'

  attributes :id,
             :name,
             :product_id

  has_many :option_values
end
