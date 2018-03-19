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
  validate :password_ok?

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
