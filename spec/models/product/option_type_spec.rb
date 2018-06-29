# == Schema Information
#
# Table name: product_option_types
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  product_id :bigint(8)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe Product::OptionType, type: :model do
  it { should belong_to :product }
  it { should have_many :option_values }
end
