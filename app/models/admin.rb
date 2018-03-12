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

# Admin Model
#
# 管理員
class Admin < ApplicationRecord
  FILTERABLE_FIELDS = %w[
    content_manager
    accounter
    stock_manager
    super
    owner
    actived
    suspended
  ].freeze
  SORTABLE_FIELDS = %w[
    id
    email
    name
    role
    is_suspended
    created_at
  ].freeze

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :recoverable, :rememberable, :trackable, :validatable

  enum role: %i[content_manager accounter stock_manager super owner]

  scope :actived, -> { where(is_suspended: false) }
  scope :suspended, -> { where(is_suspended: true) }

  # 如果 avatar 是 nil（未上傳使用者頭像），使用 null object 替代
  def avatar
    super || Null::Image.new
  end

  # 產生 JWT 供 API 認證身份
  def issue_jwt
    JsonWebToken.encode(sub: id,
                        iat: Time.current.to_i,
                        role: role,
                        type: 'Admin',
                        ref: 'web')
  end
end
