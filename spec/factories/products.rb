# == Schema Information
#
# Table name: products
#
#  id                        :bigint(8)        not null, primary key
#  name                      :string
#  description               :text
#  category_id               :bigint(8)
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
#  brand_id                  :bigint(8)
#  width                     :decimal(, )
#  depth                     :decimal(, )
#  height                    :decimal(, )
#  weight                    :decimal(, )
#

FactoryBot.define do
  factory :product do
    name 'MyString'
    original_price 100
    sell_price 1000
    discounted_price 880
    is_preorder false
    properties ''
    description 'MyText'
    association :category, factory: :product_category
  end
end
