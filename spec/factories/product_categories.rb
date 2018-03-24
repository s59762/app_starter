# == Schema Information
#
# Table name: product_categories
#
#  id          :integer          not null, primary key
#  name        :string
#  description :string
#  parent_id   :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryBot.define do
  factory :product_category do
    name 'MyString'
    description 'MyString'
  end
end
