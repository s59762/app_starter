Rails.application.routes.draw do
  devise_for :admins, skip: %i[registrations]#, controllers: { sessions: 'admins/sessions' }

  root 'pages#index'

  # Back-Stage UI for Administrators
  namespace :admin do
    root to: redirect('admin/dashboard')

    resource :dashboard, only: %i[show], controller: 'dashboard'
  end
end
