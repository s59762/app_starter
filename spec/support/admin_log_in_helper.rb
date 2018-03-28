module AdminLogInHelper
  def login_as_default_admin(role = :owner)
    _default_admin = create :admin, email: 'admin@odd.com', password: 'qwerasdf', role: role
    visit new_admin_session_path

    within('#new_admin') do
      fill_in 'admin_email', with: 'admin@odd.com'
      fill_in 'admin_password', with: 'qwerasdf'

      find('button.login-button').click
    end
  end
end

RSpec.configure do |config|
  config.include AdminLogInHelper, type: :feature
end
