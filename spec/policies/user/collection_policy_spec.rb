require 'rails_helper'

RSpec.describe User::CollectionPolicy do
  subject { described_class }

  let(:owner) { create :admin, role: :owner }
  let(:super_admin) { create :admin, role: :super }
  let(:stock_manager) { create :admin, role: :stock_manager }
  let(:accounter) { create :admin, role: :accounter }
  let(:content_manager) { create :admin, role: :content_manager }
  let(:another_admin) { create :admin, role: :content_manager }
  let(:client) { create :user }
  let(:another_client) { create :user }
  let(:product) { create :product }
  let(:collection) { create :user_collection, user: client, product: product }

  permissions :index? do
    it '只有 User 可以看到自己的收藏商品列表' do
      expect(subject).not_to permit(owner, :collection)
      expect(subject).not_to permit(super_admin, :collection)
      expect(subject).not_to permit(stock_manager, :collection)
      expect(subject).not_to permit(accounter, :collection)
      expect(subject).not_to permit(content_manager, :collection)
      expect(subject).to permit(client, :collection)
    end
  end

  permissions :show? do
    it '只有 User 自己可以看到自己的收藏商品細節' do
      expect(subject).not_to permit(owner, collection)
      expect(subject).not_to permit(super_admin, collection)
      expect(subject).not_to permit(stock_manager, collection)
      expect(subject).not_to permit(accounter, collection)
      expect(subject).not_to permit(content_manager, collection)
      expect(subject).to permit(client, collection)
      expect(subject).not_to permit(another_client, collection)
    end
  end

  permissions :create? do
    it '只有 User 可以新增收藏商品' do
      expect(subject).not_to permit(owner, :collection)
      expect(subject).not_to permit(super_admin, :collection)
      expect(subject).not_to permit(stock_manager, :collection)
      expect(subject).not_to permit(accounter, :collection)
      expect(subject).not_to permit(content_manager, :collection)
      expect(subject).to permit(client, :collection)
    end
  end

  permissions :destroy? do
    it '只有 User 自己可以刪除自己的收藏商品' do
      expect(subject).not_to permit(owner, collection)
      expect(subject).not_to permit(super_admin, collection)
      expect(subject).not_to permit(stock_manager, collection)
      expect(subject).not_to permit(accounter, collection)
      expect(subject).not_to permit(content_manager, collection)
      expect(subject).to permit(client, collection)
      expect(subject).not_to permit(another_client, collection)
    end
  end
end
