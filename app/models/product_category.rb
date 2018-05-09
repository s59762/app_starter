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

class ProductCategory < ApplicationRecord
  allow_sort_fields :id,
                    :name,
                    :created_at

  # TODO: belongs_to `root_category`, class_name: 'ProductCategory'
  #       新增 root_category_id 到 table. 用來辨識根分類是什麼。 這樣可以方便一次找出所有根分類的商品
  belongs_to :parent, class_name: 'ProductCategory', optional: true
  has_many :sub_categories, class_name: 'ProductCategory', foreign_key: 'parent_id', dependent: :destroy
  has_many :products, foreign_key: 'category_id'

  scope :top_level_only, -> { where(parent_id: nil) }
end
