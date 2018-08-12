# == Schema Information
#
# Table name: products
#
#  id               :bigint(8)        not null, primary key
#  name             :string
#  description      :text
#  category_id      :bigint(8)
#  cover            :integer
#  is_preorder      :boolean          default(FALSE)
#  properties       :jsonb
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  brand_id         :bigint(8)
#  meta_title       :string
#  meta_description :string
#  meta_keywords    :string
#  total_stock      :integer          default(0)
#

class Product < ApplicationRecord
  include EditorAttachable
  include PublicActivity::Common

  allow_sort_fields :'master.sku',
                    :name,
                    :category_id,
                    :'master.original_price_cents',
                    :'master.sell_price_cents',
                    :'master.discounted_price_cents',
                    :created_at

  belongs_to :brand, counter_cache: true, optional: true, touch: true
  belongs_to :category, class_name: 'ProductCategory', counter_cache: true, optional: true, touch: true
  has_many :images, -> { order(created_at: :asc) }, class_name: 'Product::Image', dependent: :destroy
  has_many :option_types, -> { order(created_at: :asc) }, class_name: 'Product::OptionType', dependent: :destroy, index_errors: true
  has_many :variants, -> { where(is_master: false).order(created_at: :asc) }, class_name: 'Product::Variant'
  has_many :variants_with_master, -> { order(created_at: :asc) }, class_name: 'Product::Variant', dependent: :destroy
  has_many :collections, class_name: 'User::Collection', dependent: :destroy
  has_many :activities, -> { order(created_at: :asc) }, class_name: '::PublicActivity::Activity', as: :trackable, dependent: :destroy
  has_one :master, -> { where(is_master: true) }, class_name: 'Product::Variant'

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

  delegate :sku,
           :weight,
           :width,
           :depth,
           :height,
           :original_price,
           :sell_price,
           :discounted_price, to: :master

  def master
    super || build_master
  end
end
