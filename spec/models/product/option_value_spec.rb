# == Schema Information
#
# Table name: product_option_values
#
#  id             :bigint(8)        not null, primary key
#  value          :string
#  option_type_id :bigint(8)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'rails_helper'

RSpec.describe Product::OptionValue, type: :model do
  it { should belong_to :option_type }
end
