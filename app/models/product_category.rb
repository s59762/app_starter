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
  FILTERABLE_FIELDS = %w[
    all
  ].freeze
  SORTABLE_FIELDS = %w[
    id
    name
    created_at
  ].freeze

  belongs_to :parent, class_name: 'ProductCategory', optional: true
  has_many :sub_categories, class_name: 'ProductCategory', foreign_key: 'parent_id', dependent: :destroy

  scope :top_level_only, -> { where(parent_id: nil) }
end
