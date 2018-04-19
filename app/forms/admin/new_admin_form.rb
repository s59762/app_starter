class Admin::NewAdminForm < ApplicationForm
  model Admin

  DEFAULT_PASSWORD = 'qwerasdf'.freeze

  properties :email,
             :password,
             :name,
             :role
  property :password_confirmation, virtual: true

  validates :email,
            :name,
            :role, presence: true
  validates_uniqueness_of :email
  validate :valid_email?
  validate :password_ok?

  def valid_email?
    reg = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/

    errors.add(:email, :invalid_email_format) unless reg.match?(email)
  end

  # 驗證密碼是否輸入正確
  def password_ok?
    errors.add(:password, :password_mismatch) if password != password_confirmation
  end

  # 將資料寫入 Admin
  #
  # @return [Bollean] 回傳是否成功寫入 DB
  def save
    check_password
    sync
    model.save
  end

  def check_password
    self.password = DEFAULT_PASSWORD if password.blank?
  end
end
