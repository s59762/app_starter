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

class User::CollectionSerializer < ApplicationSerializer
  attributes :id,
             :product_id,
             :user_id,
             :created_at

  to_unix_time :created_at
end
