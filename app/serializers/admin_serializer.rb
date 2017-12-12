class AdminSerializer < ApplicationSerializer
  attributes :avatar,
             :created_at,
             :email,
             :id,
             :last_sign_in_at,
             :name,
             :role,
             :sign_in_count

  to_unix_time :last_sign_in_at, :created_at
  link(:self) { api_v1_admin_path(object) }
end
