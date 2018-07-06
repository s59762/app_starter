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

class ProductSerializer < ApplicationSerializer
  attributes :id,
             :cover,
             :description,
             :discounted_price,
             :is_preorder,
             :brand_id,
             :top_level_category_id,
             :sub_category_id,
             :name,
             :original_price,
             :properties,
             :width,
             :depth,
             :height,
             :weight,
             :sell_price,
             :created_at,
             :updated_at,
             :discount_rate,
             :options,
             :sku,
             :meta_title,
             :meta_description,
             :meta_keywords,
             :total_stock

  belongs_to :brand, optional: true
  belongs_to :category, class_name: 'ProductCategory', optional: true
  has_many :images, class_name: 'Product::Image', dependent: :destroy, if: -> { instance_options[:show_images] }
  has_many :normal_images, class_name: 'Product::Image', if: -> { instance_options[:show_normal_images] }
  has_many :description_images, class_name: 'Product::Image', if: -> { instance_options[:show_description_images] }
  has_many :option_types, class_name: 'Product::OptionType', if: -> { instance_options[:show_options] }
  has_many :variants, if: -> { instance_options[:show_variants] }
  has_many :variants_with_master, if: -> { instance_options[:show_variants] }
  has_many :activities, if: -> { instance_options[:show_activities] }
  has_one :master

  to_unix_time :created_at, :updated_at
  money_to_integer :original_price,
                   :sell_price,
                   :discounted_price

  def top_level_category_id
    return object.category.parent.id if object.category.parent.present?

    object.category_id
  end

  def sub_category_id
    return nil unless object.category.parent.present?

    object.category_id
  end

  def cover
    return nil unless object.normal_images.present?

    cover = object.normal_images.cover.present? ? object.normal_images.cover.take : object.normal_images.take

    {
      url: cover.image.url,
      squal_url: cover.image.squal.url,
      thumb_url: cover.image.thumb.url
    }
  end

  # 折扣率
  def discount_rate
    return 1.0 if object.discounted_price.zero?
    return 1.0 if object.sell_price.zero?

    object.discounted_price / object.sell_price
  end

  def options
    object.option_types.map do |type|
      {
        id: type.id.to_s,
        name: type.name,
        values: type.option_values.map do |option_value|
                  {
                    id: option_value.id.to_s,
                    value: option_value.value
                  }
                end
      }
    end
  end
end
