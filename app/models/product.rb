# == Schema Information
#
# Table name: products
#
#  id                        :integer          not null, primary key
#  name                      :string
#  description               :text
#  category_id               :integer
#  cover                     :integer
#  original_price_cents      :integer          default(0), not null
#  original_price_currency   :string           default("TWD"), not null
#  sell_price_cents          :integer          default(0), not null
#  sell_price_currency       :string           default("TWD"), not null
#  discounted_price_cents    :integer          default(0), not null
#  discounted_price_currency :string           default("TWD"), not null
#  is_preorder               :boolean          default(FALSE)
#  properties                :jsonb
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#

class Product < ApplicationRecord
  FILTERABLE_FIELDS = %w[].freeze
  SORTABLE_FIELDS = %w[
    id
    name
    category_id
    original_price
    sell_price
    discounted_price
    created_at
  ].freeze

  monetize :original_price_cents,
           :sell_price_cents,
           :discounted_price_cents

  belongs_to :category, class_name: 'ProductCategory', optional: true
  has_many :images, class_name: 'Product::Image', dependent: :destroy
  has_many :normal_images, -> { where(use_case: :normal) }, class_name: 'Product::Image'
  has_many :description_images, -> { where(use_case: :description) }, class_name: 'Product::Image'

  # @param [Array] properties 搜尋 jsonb 欄位
  # @example 搜尋品牌為 ALESSI 的商品
  #   ```rb
  #   Product.search_by_properties([{name: '品牌', value: 'ALESSI'}])
  #   Product.search_by_properties([{name: '品牌'}])
  #   Product.search_by_properties([{value: 'ALESSI'}])
  #   ```
  scope :search_by_properties, ->(values) { where('properties @> ?', values.to_json) }

  # this crazy query can list all brands...
  # Product.where("properties @> ?", [{name: '品牌'}].to_json).select("json_array_elements(properties::json) ->> 'name' as name", "json_array_elements(properties::json) ->> 'value' as brand", "id").to_ary.select{|h| h[:name] == '品牌'}.map(&:brand)
end
