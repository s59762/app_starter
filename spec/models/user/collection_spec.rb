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

require 'rails_helper'

RSpec.describe User::Collection, type: :model do
  it { should belong_to :user }
  it { should belong_to :product }
end
