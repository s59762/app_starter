# == Schema Information
#
# Table name: banners
#
#  id         :bigint(8)        not null, primary key
#  image      :string
#  alt_text   :string
#  use_type   :integer          default("homepage")
#  position   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :banner do
    image "MyString"
    alt_text "MyString"
    use_type 1
    position 1
  end
end
