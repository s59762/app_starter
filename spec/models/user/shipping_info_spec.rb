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

require 'rails_helper'

RSpec.describe User::ShippingInfo, type: :model do
  it { should belong_to :user }
end
