# == Schema Information
#
# Table name: product_categories
#
#  id          :integer          not null, primary key
#  name        :string
#  description :string
#  parent_id   :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class ProductCategorySerializer < ApplicationSerializer
  attributes :id,
             :name,
             :description

  belongs_to :parent, class_name: 'ProductCategory', optional: true
  has_many :sub_categories, class_name: 'ProductCategory', foreign_key: 'parent_id'
end
