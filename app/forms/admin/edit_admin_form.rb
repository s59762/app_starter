class Admin::EditAdminForm < ApplicationForm
  model Admin

  properties :email,
             :name,
             :role
  property :new_password, virtual: true
  property :password_confirmation, virtual: true

  validates :name,
            :role, presence: true

  validate :password_ok?

  # 驗證密碼是否輸入正確
  def password_ok?
    errors.add(:new_password, :password_mismatch) if new_password != password_confirmation
  end

  # 將資料寫入 Admin
  #
  # @return [Bollean] 回傳是否成功寫入 DB
  def save
    assign_new_password
    sync
    model.save
  end

  def assign_new_password
    model.password = new_password
  end
end