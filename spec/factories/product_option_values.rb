# == Schema Information
#
# Table name: product_option_values
#
#  id             :bigint(8)        not null, primary key
#  value          :string
#  option_type_id :bigint(8)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

FactoryBot.define do
  factory :product_option_value, class: 'Product::OptionValue' do
    value "MyString"
    association :option_type, factory: :product_option_type
  end
end
