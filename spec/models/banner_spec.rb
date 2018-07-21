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

require 'rails_helper'

RSpec.describe Banner, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
