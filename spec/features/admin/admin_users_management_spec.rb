require 'rails_helper'

RSpec.feature "Admin::UsersManagement", type: :feature do
  let!(:user_1) { create(:user, email: 'test1@odd.com', password: 'qwerasdf') }
  let!(:user_2) { create(:user, email: 'test2@odd.com', password: 'qwerasdf') }

  before(:each) do
    login_as_default_admin
    visit admin_users_path
  end

  describe '使用者管理介面列表', js: true do
    it '可以列出所有使用者' do
      expect(page).to have_content(user_1.email)
      expect(page).to have_content(user_2.email)
    end

    it '可以透過完整 Email 搜尋找到特定使用者' do
      find('[data-behavior="search-user-panel"]').click

      find('[data-behavior="search-by-user-email-field"]').set user_2.email
      find('[data-behavior="search-button"]').click

      expect(page).to have_content(user_2.email)
      expect(page).to have_no_content(user_1.email)
    end

    it '可以透過 Email 模糊搜尋找到特定使用者' do
      find('[data-behavior="search-user-panel"]').click

      find('[data-behavior="search-by-user-email-field"]').set user_1.email.split('@').first
      find('[data-behavior="search-button"]').click

      expect(page).to have_content(user_1.email)
      expect(page).to have_no_content(user_2.email)
    end
  end
end
