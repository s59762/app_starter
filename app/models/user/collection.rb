# == Schema Information
#
# Table name: user_collections
#
#  id         :bigint(8)        not null, primary key
#  product_id :bigint(8)
#  user_id    :bigint(8)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class User::Collection < ApplicationRecord
  belongs_to :product
  belongs_to :user, touch: true
end
