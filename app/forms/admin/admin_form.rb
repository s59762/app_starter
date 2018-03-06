class Admin::AdminForm < ApplicationForm
  model Admin

  DEFAULT_PASSWORD = 'qwerasdf'.freeze

  properties :email,
             :password,
             :name,
             :role
  validates :email,
            :name,
            :role, presence: true
  validates_uniqueness_of :email

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