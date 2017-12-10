# Null Object for Image
#
# 未指定圖片物件時可使用 Null::Image 替代
class Null::Image
  include ActionView::Helpers::AssetUrlHelper

  # 模擬 Carrierwave 的 `url` 方法給出替代圖片 url
  def url
    'http://via.placeholder.com/300x300?text=No+image'
  end
end
