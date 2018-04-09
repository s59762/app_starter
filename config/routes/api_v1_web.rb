namespace :api do
  namespace :v1 do
    namespace :web do
      # Admin resource
      resources :admins, only: %i[index show create update] do
        collection do
          # get all roles that available for Admin
          get :roles, controller: 'admins/roles', action: :show
        end

        # suspend toggle an admin
        resource :suspend, only: %i[update], controller: 'admins/suspend'
      end

      # User resource
      resources :users, only: %i[index show]

      # ProductCategory resource
      resources :product_categories, only: %i[index create update]

      # Product resource
      resources :products, only: %i[index show create update] do
        collection do
          # Product image resource
          resources :images, only: %i[create], controller: 'products/images'
        end
      end

      # Site config
      resource :site_config, only: %i[show], controller: 'site_config' do
        resource :meta_tags, only: %i[update], controller: 'site_config/meta_tags'
      end
    end
  end
end
