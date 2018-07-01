class Admin::ProductOptionValueForm < ApplicationForm
  model Product::OptionValue

  properties :value

  validates :value, presence: true

  # 將資料寫入 ModelName
  #
  # @return [Bollean] 回傳是否成功寫入 DB
  # def save
  #   super
  # end
end
