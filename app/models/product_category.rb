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

class ProductCategory < ApplicationRecord
  allow_sort_fields :id,
                    :name,
                    :products_count,
                    :created_at

  # TODO: products_count 無法排序
  # TODO: belongs_to `root_category`, class_name: 'ProductCategory'
  #       新增 root_category_id 到 table. 用來辨識根分類是什麼。 這樣可以方便一次找出所有根分類的商品
  belongs_to :parent, class_name: 'ProductCategory', optional: true, touch: true
  has_many :sub_categories, class_name: 'ProductCategory', foreign_key: 'parent_id', dependent: :destroy
  has_many :products, foreign_key: 'category_id'

  scope :top_level_only, -> { where(parent_id: nil) }
end
