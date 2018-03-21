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

class User < ApplicationRecord
  FILTERABLE_FIELDS = %w[].freeze
  SORTABLE_FIELDS = %w[
    id
    email
    created_at
  ].freeze

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # 產生 JWT 供 API 認證身份
  def issue_jwt
    JsonWebToken.encode(sub: id,
                        iat: Time.current.to_i,
                        type: 'User',
                        ref: 'web')
  end

  def guest?
    false
  end
end
