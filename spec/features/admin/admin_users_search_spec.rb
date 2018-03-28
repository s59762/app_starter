require 'rails_helper'

RSpec.feature "Admin::UsersSearch", type: :feature do

  let!(:admin) { create(:admin, email: 'admin@odd.com', password: 'qwerasdf') }
  let!(:user_1) { create(:user, email: 'test1@odd.com', password: 'qwerasdf') }
  let!(:user_2) { create(:user, email: 'test2@odd.com', password: 'qwerasdf') }

  before(:each) do
    visit new_admin_session_path

    within('#new_admin') do
      fill_in 'admin_email', with: 'admin@odd.com'
      fill_in 'admin_password', with: 'qwerasdf'

      find('button.login-button').click
    end
  end

  describe '使用者管理介面列表', feature: true do
    it '可以透過 Email 搜尋找到特定使用者' do
      visit admin_users_path
      find('#search-user-panel').click

      # search user 1
      fill_in 'search-by-user-email', with: user_1.email
      click_button 'search-button'

      expect(page).to have_content(user_1.email)
      expect(page).to have_no_content(user_2.email)

      # search user 2
      fill_in 'search-by-user-email', with: user_2.email
      click_button 'search-button'

      expect(page).to have_content(user_2.email)
      expect(page).to have_no_content(user_1.email)
    end
  end
end
