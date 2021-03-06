# == Schema Information
#
# Table name: admins
#
#  id                     :bigint(8)        not null, primary key
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
             :is_suspended,
             :updated_at

  has_many :activity_records, if: -> { instance_options[:show_activity_records] }

  to_unix_time :last_sign_in_at, :created_at, :updated_at
end
