class Admin::BrandBannerForm < ApplicationForm
  model Brand::Banner

  properties :image,
             :alt_text,
             :brand_id

  validates :image,
            :alt_text,
            :brand_id, presence: true

  # 將資料寫入 ModelName
  #
  # @return [Bollean] 回傳是否成功寫入 DB
  # def save
  #   super
  # end
end
