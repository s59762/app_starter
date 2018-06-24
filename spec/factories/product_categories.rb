# == Schema Information
#
# Table name: product_categories
#
#  id             :bigint(8)        not null, primary key
#  name           :string
#  description    :string
#  parent_id      :bigint(8)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  products_count :integer          default(0)
#

FactoryBot.define do
  factory :product_category do
    name 'MyString'
    description 'MyString'
  end
end
