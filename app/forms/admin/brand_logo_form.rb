class Admin::BrandLogoForm < ApplicationForm
  model Brand

  properties :logo
  validates :logo, presence: true

  # 將資料寫入 ModelName
  #
  # @return [Bollean] 回傳是否成功寫入 DB
  # def save
  #   super
  # end
end
