# == Schema Information
#
# Table name: brand_banners
#
#  id         :bigint(8)        not null, primary key
#  image      :string
#  alt_text   :string
#  brand_id   :bigint(8)
#  position   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :brand_banner, class: 'Brand::Banner' do
    image "MyString"
    alt_text "MyString"
    brand
  end
end
