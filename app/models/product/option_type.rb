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

class Product::OptionType < ApplicationRecord
  belongs_to :product

  has_many :option_values, class_name: 'Product::OptionValue', dependent: :destroy
end
