namespace :api do
  namespace :v1 do
    namespace :web do
      # Admin resource
      resources :admins, only: %i(index show create update) do
        collection do
          # get all roles that available for Admin
          get :roles, controller: 'admins/roles', action: :show
        end

        # suspend toggle an admin
        resource :suspend, only: %i(update), controller: 'admins/suspend'
      end

      # User resource
      resources :users, only: %i(index show) do
        collection do
          resources :collections, only: %i(index destroy), controller: 'users/collections', as: :user_collections
        end

        resources :shipping_infos, only: %i(index create update destroy), controller: 'users/shipping_infos'
      end

      # Brand resource
      resources :brands, only: %i(index show create update) do
        resource :logo, only: :update, controller: 'brands/logo'
        resources :products, only: :index, controller: 'brands/products'
        resources :banners, only: :index, controller: 'brands/banners'
      end

      # ProductCategory resource
      resources :product_categories, only: %i(index create update)

      # Product resource
      resources :products, only: %i(index show create update) do
        collection do
          resources :images, only: %i(create), controller: 'products/images'
        end

        resource :collect, only: %i(create destroy), controller: 'products/collect'
      end
      resources :product_option_types, only: %i(update destroy), controller: 'products/option_types'
      resources :product_option_values, only: %i(update destroy), controller: 'products/option_values'
      resources :product_variants, only: %i(update), controller: 'products/variants' do
        resource :set_as_master, only: :update, controller: 'products/variants/set_as_master'
        resource :stock, only: :update, controller: 'products/variants/stock'
      end
      resources :product_images, only: %i(destroy), controller: 'products/images' do
        resource :set_as_cover, only: :update, controller: 'products/images/set_as_cover'
        resource :assign_to_variant, only: :update, controller: 'products/images/assign_to_variant'
      end

      # Banners
      resources :banners, only: %i(index create update destroy) do
        collection do
          resource :use_type, only: :show, controller: 'banners/use_type'
        end
      end
      resources :brand_banners, only: %i(create update destroy), controller: 'brands/banners', as: :brand_banners

      # Editor Attachment resource
      resources :editor_attachments, only: %i(create destroy)

      # REMOVE: cart not useable now
      resource :cart, only: %i(show), controller: 'cart'

      # Site config
      resource :site_config, only: %i(show), controller: 'site_config' do
        resource :meta_tags, only: %i(update), controller: 'site_config/meta_tags'
      end
    end
  end
end
