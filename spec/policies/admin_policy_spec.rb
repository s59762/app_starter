
require 'rails_helper'

RSpec.describe AdminPolicy do
  subject { described_class }

  let(:owner) { create :admin, role: :owner }
  let(:super_admin) { create :admin, role: :super }
  let(:stock_manager) { create :admin, role: :stock_manager }
  let(:accounter) { create :admin, role: :accounter }
  let(:content_manager) { create :admin, role: :content_manager }
  let(:another_admin) { create :admin, role: :content_manager }
  let(:client) { create :user }

  permissions :index? do
    it '只有 owner 和 super 可以看到成員列表' do
      expect(subject).to permit(owner, :admin)
      expect(subject).to permit(super_admin, :admin)
      expect(subject).not_to permit(stock_manager, :admin)
      expect(subject).not_to permit(accounter, :admin)
      expect(subject).not_to permit(content_manager, :admin)
      expect(subject).not_to permit(client, :admin)
    end
  end

  permissions :show? do
    it '只有 owner, super, 和自己本身可以查看成員詳細資料' do
      expect(subject).to permit(owner, another_admin)
      expect(subject).to permit(super_admin, another_admin)
      expect(subject).not_to permit(stock_manager, another_admin)
      expect(subject).not_to permit(accounter, another_admin)
      expect(subject).not_to permit(content_manager, another_admin)
      expect(subject).to permit(another_admin, another_admin)
      expect(subject).not_to permit(client, another_admin)
    end
  end

  permissions :create? do
    it '只有 owner, super 可以建立新成員' do
      expect(subject).to permit(owner, :admin)
      expect(subject).to permit(super_admin, :admin)
      expect(subject).not_to permit(stock_manager, :admin)
      expect(subject).not_to permit(accounter, :admin)
      expect(subject).not_to permit(content_manager, :admin)
      expect(subject).not_to permit(client, :admin)
    end
  end

  permissions :update? do
    it '只有 owner, super 可以更新成員資料' do
      expect(subject).to permit(owner, another_admin)
      expect(subject).to permit(super_admin, another_admin)
      expect(subject).not_to permit(stock_manager, another_admin)
      expect(subject).not_to permit(accounter, another_admin)
      expect(subject).not_to permit(content_manager, another_admin)
      expect(subject).not_to permit(another_admin, another_admin)
      expect(subject).not_to permit(client, another_admin)
    end
  end

  permissions :suspend? do
    it '只有 owner, super 可以將成員停權' do
      expect(subject).to permit(owner, another_admin)
      expect(subject).to permit(super_admin, another_admin)
      expect(subject).not_to permit(stock_manager, another_admin)
      expect(subject).not_to permit(accounter, another_admin)
      expect(subject).not_to permit(content_manager, another_admin)
      expect(subject).not_to permit(another_admin, another_admin)
      expect(subject).not_to permit(client, another_admin)
    end
  end

  permissions :roles? do
    it '只有 owner, super 可以查看成員角色列表' do
      expect(subject).to permit(owner, :admin)
      expect(subject).to permit(super_admin, :admin)
      expect(subject).not_to permit(stock_manager, :admin)
      expect(subject).not_to permit(accounter, :admin)
      expect(subject).not_to permit(content_manager, :admin)
      expect(subject).not_to permit(client, :admin)
    end
  end
end
