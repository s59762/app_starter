require 'rails_helper'

RSpec.feature "Admin::AdminsManagement", type: :feature do
  let!(:admin_1) { create(:admin) }
  let!(:admin_2) { create(:admin) }

  before(:each) do
    login_as_default_admin
    visit admin_admins_path
  end

  describe '成員列表' do
    it '應該要顯示所有成員' do
      # 包含 default admin 應該要有三個成員
      expect(page).to have_selector('[data-behavior="admin-list"] tbody tr', count: 3)
    end
  end

  describe '新增成員', js: true do
    it '可以透過新增成員按鈕打開表單，新增一個成員' do
      find('[data-behavior="new-admin-button"]').click

      # search user 1
      find('[data-behavior="admin-email"]').set 'test@test.com'
      find('[data-behavior="admin-name"]').set '測試成員'
      find('option[value="accounter"]').click

      find('[data-behavior="submit-button"]').click

      expect(page).to have_content('測試成員')
    end
  end

  describe '編輯成員', js: true do
    it '可以透過編輯按鈕修改成員資料' do
      find('[data-behavior="admin-list"] tbody tr', match: :first)
      all('[data-behavior="admin-list"] tbody tr')[1].find('[data-behavior="edit-button"]').click

      find('[data-behavior="admin-name"]').set '編輯過了'

      find('[data-behavior="submit-button"]').click

      expect(page).to have_content('編輯過了')
    end
  end
end
