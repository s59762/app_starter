Rails.application.routes.draw do
  devise_for :admins, path: 'admin',
                      path_names: {
                        sign_in: 'login',
                        sign_out: 'logout'
                      }

  root 'pages#index'

  # Back-Stage UI for Administrators
  namespace :admin do
    root to: redirect('admin/dashboard')

    resource :dashboard, only: %i[show], controller: 'dashboard'
  end
end
