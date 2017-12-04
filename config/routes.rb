Rails.application.routes.draw do
  devise_for :admins, skip: %i[registrations]#, controllers: { sessions: 'admins/sessions' }

  root 'pages#index'

  # Back-Stage UI for Administrators
  namespace :admin do
    root 'dashboard#index'
  end
end
