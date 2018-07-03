# == Schema Information
#
# Table name: products
#
#  id               :bigint(8)        not null, primary key
#  name             :string
#  description      :text
#  category_id      :bigint(8)
#  cover            :integer
#  is_preorder      :boolean          default(FALSE)
#  properties       :jsonb
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  brand_id         :bigint(8)
#  meta_title       :string
#  meta_description :string
#  meta_keywords    :string
#  total_stock      :integer          default(0)
#

require 'rails_helper'

RSpec.describe Product, type: :model do
  it { should belong_to :brand }
  it { should belong_to :category }
  it { should have_many :images }
  it { should have_many :normal_images }
  it { should have_many :description_images }
  it { should have_many :option_types }
  it { should have_many :variants }
  it { should have_one :master }
  it { should have_many :variants_with_master }
end
