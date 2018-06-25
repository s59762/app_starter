require 'rails_helper'

RSpec.describe UserPolicy do
  subject { described_class }

  let(:owner) { create :admin, role: :owner }
  let(:super_admin) { create :admin, role: :super }
  let(:stock_manager) { create :admin, role: :stock_manager }
  let(:accounter) { create :admin, role: :accounter }
  let(:content_manager) { create :admin, role: :content_manager }
  let(:another_admin) { create :admin, role: :content_manager }
  let(:client) { create :user }
  let(:another_client) { create :user }

  permissions :index? do
    it '只有 Owner、Super 和 Accounter 可以看到會員列表' do
      expect(subject).to permit(owner, :user)
      expect(subject).to permit(super_admin, :user)
      expect(subject).not_to permit(stock_manager, :user)
      expect(subject).to permit(accounter, :user)
      expect(subject).not_to permit(content_manager, :user)
      expect(subject).not_to permit(client, :user)
    end
  end

  permissions :show? do
    it '只有 Owner、Super 和 Accounter，以及 User 自己可以看到會員詳細資料' do
      expect(subject).to permit(owner, client)
      expect(subject).to permit(super_admin, client)
      expect(subject).not_to permit(stock_manager, client)
      expect(subject).to permit(accounter, client)
      expect(subject).not_to permit(content_manager, client)
      expect(subject).to permit(client, client)
      expect(subject).not_to permit(another_client, client)
    end
  end

  permissions :collections? do
    it '只有 User 可以看到自己的收藏商品列表' do
      expect(subject).not_to permit(owner, :user)
      expect(subject).not_to permit(super_admin, :user)
      expect(subject).not_to permit(stock_manager, :user)
      expect(subject).not_to permit(accounter, :user)
      expect(subject).not_to permit(content_manager, :user)
      expect(subject).to permit(client, :user)
    end
  end
end
