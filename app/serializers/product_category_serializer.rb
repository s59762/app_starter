# == Schema Information
#
# Table name: product_categories
#
#  id             :bigint(8)        not null, primary key
#  name           :string
#  description    :string
#  parent_id      :bigint(8)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  products_count :integer          default(0)
#

class ProductCategorySerializer < ApplicationSerializer
  attributes :id,
             :name,
             :description,
             :parent_id,
             :products_count,
             :created_at,
             :updated_at

  belongs_to :parent, class_name: 'ProductCategory', optional: true
  has_many :sub_categories, class_name: 'ProductCategory', foreign_key: 'parent_id'
  has_many :products, foreign_key: 'category_id', if: -> { instance_options[:show_products] }

  to_unix_time :created_at, :updated_at
end
