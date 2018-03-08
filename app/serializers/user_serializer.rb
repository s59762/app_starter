# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class UserSerializer < ApplicationSerializer
  attributes :created_at,
             :email,
             :id,
             :last_sign_in_at,
             :sign_in_count

  to_unix_time :last_sign_in_at, :created_at
  link(:self) { api_v1_web_user_path(object) }
end
