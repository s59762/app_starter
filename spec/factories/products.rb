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

FactoryBot.define do
  factory :product do
    name 'MyString'
    is_preorder false
    properties ''
    description 'MyText'
    association :category, factory: :product_category
  end
end
