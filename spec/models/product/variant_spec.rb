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

require 'rails_helper'

RSpec.describe Product::Variant, type: :model do
  it { should belong_to :product }
end
