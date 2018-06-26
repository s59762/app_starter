require 'rails_helper'

RSpec.describe User::ShippingInfoPolicy do
  subject { described_class }

  let(:owner) { create :admin, role: :owner }
  let(:super_admin) { create :admin, role: :super }
  let(:stock_manager) { create :admin, role: :stock_manager }
  let(:accounter) { create :admin, role: :accounter }
  let(:content_manager) { create :admin, role: :content_manager }
  let(:another_admin) { create :admin, role: :content_manager }
  let(:client) { create :user }
  let(:another_client) { create :user }
  let(:user_shipping_info) { create :user_shipping_info, user: client }

  permissions :index? do
    it '只有 User 自己可以看到自己的常用收件人列表' do
      expect(subject).not_to permit(owner, client)
      expect(subject).not_to permit(super_admin, client)
      expect(subject).not_to permit(stock_manager, client)
      expect(subject).not_to permit(accounter, client)
      expect(subject).not_to permit(content_manager, client)
      expect(subject).to permit(client, client)
    end
  end

  permissions :create? do
    it '只有 User 可以新增收藏商品' do
      expect(subject).not_to permit(owner, client)
      expect(subject).not_to permit(super_admin, client)
      expect(subject).not_to permit(stock_manager, client)
      expect(subject).not_to permit(accounter, client)
      expect(subject).not_to permit(content_manager, client)
      expect(subject).to permit(client, client)
    end
  end

  permissions :update? do
    it '只有 User 自己可以更新自己的常用收件人列表' do
      expect(subject).not_to permit(owner, user_shipping_info)
      expect(subject).not_to permit(super_admin, user_shipping_info)
      expect(subject).not_to permit(stock_manager, user_shipping_info)
      expect(subject).not_to permit(accounter, user_shipping_info)
      expect(subject).not_to permit(content_manager, user_shipping_info)
      expect(subject).to permit(client, user_shipping_info)
      expect(subject).not_to permit(another_client, user_shipping_info)
    end
  end

  permissions :destroy? do
    it '只有 User 自己可以刪除自己的收藏商品' do
      expect(subject).not_to permit(owner, user_shipping_info)
      expect(subject).not_to permit(super_admin, user_shipping_info)
      expect(subject).not_to permit(stock_manager, user_shipping_info)
      expect(subject).not_to permit(accounter, user_shipping_info)
      expect(subject).not_to permit(content_manager, user_shipping_info)
      expect(subject).to permit(client, user_shipping_info)
      expect(subject).not_to permit(another_client, user_shipping_info)
    end
  end
end
