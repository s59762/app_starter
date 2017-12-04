Rails.application.routes.draw do
  root 'pages#index'

  # Back-Stage UI for Administrators
  namespace :admin do
    root 'dashboard#index'
  end
end
