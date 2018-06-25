require 'rails_helper'

RSpec.describe ProductPolicy do
  subject { described_class }

  let(:owner) { create :admin, role: :owner }
  let(:super_admin) { create :admin, role: :super }
  let(:stock_manager) { create :admin, role: :stock_manager }
  let(:accounter) { create :admin, role: :accounter }
  let(:content_manager) { create :admin, role: :content_manager }
  let(:another_admin) { create :admin, role: :content_manager }
  let(:client) { create :user }
  let(:category) { create :product_category }
  let(:brand) { create :brand }
  let(:product) { create :product, category: category, brand: brand }

  permissions :index? do
    it '所有使用者都可以查看商品列表' do
      expect(subject).to permit(owner, :category)
      expect(subject).to permit(super_admin, :category)
      expect(subject).to permit(stock_manager, :category)
      expect(subject).to permit(accounter, :category)
      expect(subject).to permit(content_manager, :category)
      expect(subject).to permit(client, :category)
    end
  end

  permissions :show? do
    it '所有使用者都可以查看商品詳細內容' do
      expect(subject).to permit(owner, category)
      expect(subject).to permit(super_admin, category)
      expect(subject).to permit(stock_manager, category)
      expect(subject).to permit(accounter, category)
      expect(subject).to permit(content_manager, category)
      expect(subject).to permit(client, category)
    end
  end

  permissions :create? do
    it '只有 Owner、Super 和 Stock Manager 可以建立商品' do
      expect(subject).to permit(owner, :category)
      expect(subject).to permit(super_admin, :category)
      expect(subject).to permit(stock_manager, :category)
      expect(subject).not_to permit(accounter, :category)
      expect(subject).not_to permit(content_manager, :category)
      expect(subject).not_to permit(client, :category)
    end
  end

  permissions :update? do
    it '只有 Owner、Super 和 Stock Manager 可以更新商品' do
      expect(subject).to permit(owner, category)
      expect(subject).to permit(super_admin, category)
      expect(subject).to permit(stock_manager, category)
      expect(subject).not_to permit(accounter, category)
      expect(subject).not_to permit(content_manager, category)
      expect(subject).not_to permit(client, category)
    end
  end
end
