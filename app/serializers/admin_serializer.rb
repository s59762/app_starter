# == Schema Information
#
# Table name: admins
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
#  avatar                 :string
#  name                   :string
#  role                   :integer          default("content_manager")
#  is_suspended           :boolean          default(FALSE)
#

class AdminSerializer < ApplicationSerializer
  attributes :avatar,
             :created_at,
             :email,
             :id,
             :last_sign_in_at,
             :name,
             :role,
             :sign_in_count,
             :is_suspended

  to_unix_time :last_sign_in_at, :created_at
  link(:self) { api_v1_web_admin_path(object) }
end
