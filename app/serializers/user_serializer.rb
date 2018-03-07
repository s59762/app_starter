class UserSerializer < ApplicationSerializer
  attributes :created_at,
             :email,
             :id,
             :last_sign_in_at,
             :sign_in_count

  to_unix_time :last_sign_in_at, :created_at
  link(:self) { api_v1_web_user_path(object) }
end
