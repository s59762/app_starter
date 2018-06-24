class Admin::BrandForm < ApplicationForm
  model Brand

  properties :name,
             :introduce,
             :description
  validates :name, presence: true

  # 將資料寫入 ModelName
  #
  # @return [Bollean] 回傳是否成功寫入 DB
  # def save
  #   super
  # end
end
