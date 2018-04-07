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

class ProductSerializer < ApplicationSerializer
  attributes :id,
             :cover,
             :description,
             :discounted_price,
             :is_preorder,
             :name,
             :original_price,
             :properties,
             :sell_price,
             :created_at,
             :discount_rate

  belongs_to :category, class_name: 'ProductCategory', optional: true
  has_many :images, class_name: 'Product::Image', dependent: :destroy, if: -> { instance_options[:show_images] }
  has_many :normal_images, -> { where(use_case: :normal) }, class_name: 'Product::Image', if: -> { instance_options[:show_normal_images] }
  has_many :description_images, -> { where(use_case: :description) }, class_name: 'Product::Image', if: -> { instance_options[:show_description_images] }

  to_unix_time :created_at
  money_to_integer :original_price,
                   :sell_price,
                   :discounted_price

  # 折扣率
  def discount_rate
    return nil unless object.discounted_price.present?

    object.discounted_price / object.sell_price
  end
end
