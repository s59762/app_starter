# sidekiq monitor web UI
if Rails.env.development?
  mount Sidekiq::Web => "/admin/sidekiq"
else
  authenticate :admin do
    mount Sidekiq::Web => '/admin/sidekiq'
  end
end
