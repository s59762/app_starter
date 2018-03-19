# Back-Stage UI for Administrators
namespace :admin do
  root to: redirect('admin/dashboard')

  # admin profile page
  resource :profile, only: %i[show update], controller: 'profile' do
    resource :password, only: %i[update], controller: 'profile/password'
  end

  # dashboard
  resource :dashboard, only: %i[show], controller: 'dashboard'

  # admin management
  resources :admins, only: %i[index show]

  # user management
  resources :users, only: %i[index show]

  # system config
  resource :system_config, only: %i[show], controller: 'system_config'
end
