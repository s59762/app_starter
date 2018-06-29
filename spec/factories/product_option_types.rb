# == Schema Information
#
# Table name: product_option_types
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  product_id :bigint(8)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :product_option_type, class: 'Product::OptionType' do
    name "MyString"
    product
  end
end
