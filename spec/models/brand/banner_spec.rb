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

require 'rails_helper'

RSpec.describe Brand::Banner, type: :model do
  it { should belong_to :brand }
end
