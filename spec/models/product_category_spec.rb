# == Schema Information
#
# Table name: product_categories
#
#  id          :bigint(8)        not null, primary key
#  name        :string
#  description :string
#  parent_id   :bigint(8)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe ProductCategory, type: :model do
  context '有子分類的情況下' do
    let!(:parent) { create(:product_category) }
    let!(:child) { create(:product_category, parent_id: parent.id) }

    it '子分類應該可以找到父分類' do
      expect(child.parent).to eq parent
    end

    it '父分類應該可以找到子分類' do
      expect(parent.sub_categories.take).to eq child
    end

    it '應該可以創造複數層關聯' do
      grandson = create(:product_category, parent_id: child.id)

      expect(child.sub_categories.take).to eq grandson
      expect(grandson.parent).to eq child
    end
  end

  # associations
  it { should have_many :sub_categories }
  it { should have_many :products }
end
