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

class User::ShippingInfoSerializer < ApplicationSerializer
  type 'user_shipping_infos'
  attributes :id,
             :recipient,
             :phone,
             :address

  belongs_to :user, if: -> { instance_options[:show_user] }
end
