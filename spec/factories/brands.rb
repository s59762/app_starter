# == Schema Information
#
# Table name: brands
#
#  id          :bigint(8)        not null, primary key
#  name        :string
#  introduce   :string
#  description :string
#  logo        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

FactoryBot.define do
  factory :brand do
    name "MyString"
    introduce "MyString"
    description "MyString"
    logo "MyString"
  end
end
