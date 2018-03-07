Rails.application.routes.draw do
  devise_for :users, path: 'admin',
                     skip: %w[password],
                     path_names: {
                       sign_in: 'login',
                       sign_out: 'logout'
                     },
                     controllers: {
                       sessions: 'devise/users/sessions'
                     }
  devise_for :admins, path: 'admin',
                      skip: %w[password],
                      path_names: {
                        sign_in: 'login',
                        sign_out: 'logout'
                      },
                      controllers: {
                        sessions: 'devise/admins/sessions'
                      }

  root 'pages#index'

  # Back-Stage UI for Administrators
  namespace :admin do
    root to: redirect('admin/dashboard')

    resource :dashboard, only: %i[show], controller: 'dashboard'
    resources :admins, only: %i[index show]
    resources :users, only: %i[index show]
    resource :profile, only: %i[show update], controller: 'profile' do
      resource :password, only: %i[update], controller: 'profile/password'
    end
  end

  # API routes
  namespace :api do
    namespace :v1 do
      namespace :web do
        resources :admins, only: %i[index show create update] do
          collection do
            get :roles, controller: 'admins/roles', action: 'show'
          end
          resource :suspend, only: %i[update], controller: 'admins/suspend'
        end
      end
    end
  end
end
