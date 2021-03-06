# == Schema Information
#
# Table name: product_variants
#
#  id                        :bigint(8)        not null, primary key
#  name                      :string
#  sku                       :string
#  original_price_cents      :integer          default(0), not null
#  original_price_currency   :string           default("TWD"), not null
#  sell_price_cents          :integer          default(0), not null
#  sell_price_currency       :string           default("TWD"), not null
#  discounted_price_cents    :integer          default(0), not null
#  discounted_price_currency :string           default("TWD"), not null
#  weight                    :decimal(, )
#  width                     :decimal(, )
#  depth                     :decimal(, )
#  height                    :decimal(, )
#  is_master                 :boolean          default(FALSE)
#  description               :text
#  product_id                :bigint(8)
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  option_value_ids          :jsonb
#  stock                     :integer          default(0)
#

class Product::VariantSerializer < ApplicationSerializer
  type 'product_variants'

  attributes :id,
             :name,
             :sku,
             :sell_price,
             :discounted_price,
             :weight,
             :width,
             :depth,
             :height,
             :is_master,
             :description,
             :product_id,
             :option_value_ids,
             :stock,
             :stock_status

  money_to_integer :original_price,
                   :sell_price,
                   :discounted_price

  has_many :images

  def stock_status
    return :no_stock if object.stock <= 0
    return :low_stock if object.stock < SiteConfig.product_config['safe_stock_level']

    :normal
  end

  class Detail < Product::VariantSerializer
    attributes :original_price
  end
end
