require 'rails_helper'

RSpec.describe BrandPolicy do
  subject { described_class }

  let(:owner) { create :admin, role: :owner }
  let(:super_admin) { create :admin, role: :super }
  let(:stock_manager) { create :admin, role: :stock_manager }
  let(:accounter) { create :admin, role: :accounter }
  let(:content_manager) { create :admin, role: :content_manager }
  let(:another_admin) { create :admin, role: :content_manager }
  let(:client) { create :user }
  let(:brand) { create :brand }

  permissions :index? do
    it '所有使用者都可以查看品牌列表' do
      expect(subject).to permit(owner, :brand)
      expect(subject).to permit(super_admin, :brand)
      expect(subject).to permit(stock_manager, :brand)
      expect(subject).to permit(accounter, :brand)
      expect(subject).to permit(content_manager, :brand)
      expect(subject).to permit(client, :brand)
    end
  end

  permissions :show? do
    it '所有使用者都可以查看品牌詳細內容' do
      expect(subject).to permit(owner, brand)
      expect(subject).to permit(super_admin, brand)
      expect(subject).to permit(stock_manager, brand)
      expect(subject).to permit(accounter, brand)
      expect(subject).to permit(content_manager, brand)
      expect(subject).to permit(client, brand)
    end
  end

  permissions :create? do
    it '只有 Owner、Super 和 Stock Manager 可以建立品牌' do
      expect(subject).to permit(owner, :brand)
      expect(subject).to permit(super_admin, :brand)
      expect(subject).to permit(stock_manager, :brand)
      expect(subject).not_to permit(accounter, :brand)
      expect(subject).not_to permit(content_manager, :brand)
      expect(subject).not_to permit(client, :brand)
    end
  end

  permissions :update? do
    it '只有 Owner、Super 和 Stock Manager 可以更新品牌' do
      expect(subject).to permit(owner, brand)
      expect(subject).to permit(super_admin, brand)
      expect(subject).to permit(stock_manager, brand)
      expect(subject).not_to permit(accounter, brand)
      expect(subject).not_to permit(content_manager, brand)
      expect(subject).not_to permit(client, brand)
    end
  end
end
