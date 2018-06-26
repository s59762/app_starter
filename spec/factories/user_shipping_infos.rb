# == Schema Information
#
# Table name: user_shipping_infos
#
#  id         :bigint(8)        not null, primary key
#  recipient  :string
#  phone      :string
#  address    :jsonb
#  user_id    :bigint(8)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :user_shipping_info, class: 'User::ShippingInfo' do
    recipient "MyString"
    phone "MyString"
    address ""
    user
  end
end
