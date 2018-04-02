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
  monetize :original_price_cents,
           :sell_price_cents,
           :discounted_price_cents

  belongs_to :category, class_name: 'ProductCategory', optional: true

  # @param [Array] properties 搜尋 jsonb 欄位
  # @example 搜尋品牌為 ALESSI 的商品
  #   ```rb
  #   Product.search_by_properties([{name: '品牌', value: 'ALESSI'}])
  #   Product.search_by_properties([{name: '品牌'}])
  #   Product.search_by_properties([{value: 'ALESSI'}])
  #   ```
  scope :search_by_properties, ->(values) { where('properties @> ?', values.to_json) }
end
