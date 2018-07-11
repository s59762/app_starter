require 'sidekiq/web'

Rails.application.routes.draw do
  # 將 routes 拆到獨立的檔案管理，再使用 draw 來引入
  #
  # @param [Symbol] route_name route 的名稱，需與檔名一致
  def draw(routes_name)
    instance_eval(File.read(Rails.root.join("config/routes/#{routes_name}.rb")))
  end

  devise_for :users, path: :user,
                     skip: %w(password),
                     path_names: {
                       sign_in: 'login',
                       sign_out: 'logout'
                     },
                     controllers: {
                       sessions: 'devise/users/sessions'
                     }
  devise_for :admins, path: 'admin',
                      skip: %w(password),
                      path_names: {
                        sign_in: 'login',
                        sign_out: 'logout'
                      },
                      controllers: {
                        sessions: 'devise/admins/sessions'
                      }

  # for bot only
  resource :robots, only: [:show]

  root 'pages#index'

  draw :admin
  draw :api_v1_web
  draw :sidekiq
end
