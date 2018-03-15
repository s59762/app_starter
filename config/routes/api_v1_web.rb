namespace :api do
  namespace :v1 do
    namespace :web do
      # Admin resource
      resources :admins, only: %i[index show create update] do
        collection do
          # get all roles that available for Admin
          get :roles, controller: 'admins/roles', action: 'show'
        end

        # suspend toggle an admin
        resource :suspend, only: %i[update], controller: 'admins/suspend'
      end

      # User resource
      resources :users, only: %i[index show]
    end
  end
end
