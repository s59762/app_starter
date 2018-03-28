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
      page.should have_selector('#admin-list tbody tr', count: 3)
    end
  end

  describe '新增成員', js: true do
    it '可以透過新增成員按鈕打開表單，新增一個成員' do
      find('#new-admin-button').click

      # search user 1
      fill_in 'admin-email', with: 'test@test.com'
      fill_in 'admin-name', with: '測試成員'
      select '會計帳號', from: 'admin-role'

      find('button#admin-submit').click

      expect(page).to have_content('測試成員')
    end
  end
end
