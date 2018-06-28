# == Schema Information
#
# Table name: products
#
#  id                        :bigint(8)        not null, primary key
#  name                      :string
#  description               :text
#  category_id               :bigint(8)
#  cover                     :integer
#  original_price_cents      :integer          default(0), not null
#  original_price_currency   :string           default("TWD"), not null
#  sell_price_cents          :integer          default(0), not null
#  sell_price_currency       :string           default("TWD"), not null
#  discounted_price_cents    :integer          default(0), not null
#  discounted_price_currency :string           default("TWD"), not null
#  is_preorder               :boolean          default(FALSE)
#  properties                :jsonb
#  created_at                :datetime         not null
#  updated_at                :datetime         not null
#  brand_id                  :bigint(8)
#  width                     :decimal(, )
#  depth                     :decimal(, )
#  height                    :decimal(, )
#  weight                    :decimal(, )
#

require 'rails_helper'

RSpec.describe Product, type: :model do
  it { should belong_to :brand }
  it { should belong_to :category }
  it { should have_many :images }
  it { should have_many :normal_images }
  it { should have_many :description_images }
  it { should have_many :option_types }
end
