# == Schema Information
#
# Table name: users
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
#

class User < ApplicationRecord
  allow_sort_fields :id,
                    :email,
                    :created_at

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :collections, class_name: 'User::Collection', dependent: :destroy
  has_many :shipping_infos, class_name: 'User::ShippingInfo', dependent: :destroy

  # 產生 JWT 供 API 認證身份
  def issue_jwt
    JsonWebToken.encode(sub: id,
                        iat: Time.current.to_i,
                        exp: 1.hour.from_now.to_i,
                        type: 'User',
                        ref: 'web')
  end

  def guest?
    false
  end
end
