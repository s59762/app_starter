# == Schema Information
#
# Table name: product_images
#
#  id                :bigint(8)        not null, primary key
#  image             :string
#  original_filename :string
#  product_id        :bigint(8)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  is_cover          :boolean          default(FALSE)
#  variant_id        :bigint(8)
#

require 'rails_helper'

RSpec.describe Product::Image, type: :model do
  it { should belong_to :product }
  it { should belong_to :variant }
end
