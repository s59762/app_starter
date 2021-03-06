# == Schema Information
#
# Table name: brands
#
#  id             :bigint(8)        not null, primary key
#  name           :string
#  introduce      :string
#  description    :text
#  logo           :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  products_count :integer          default(0)
#

require 'rails_helper'

RSpec.describe Brand, type: :model do
  it { should have_many :products }
  it { should have_many :banners }
  it { should have_many :editor_attachments }
end
