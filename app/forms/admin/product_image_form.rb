class Admin::ProductImageForm < ApplicationForm
  model Product::Image

  property :images, virtual: true
  properties :product_id,
             :variant_id

  validate :valid_images_content?

  # 將資料寫入 Product::Image
  #
  # @return [Bollean] 回傳是否成功寫入 DB
  def save
    ::ActiveRecord::Base.transaction do
      images.each do |file|
        new_image = Product::Image.create image: file, product_id: product_id, variant_id: variant_id
        created_image_ids << new_image.id
      end
    end
  end

  def created_image_ids
    @created_image_ids ||= []
  end

  def valid_images_content?
    errors.add(:images, :blank) if images.blank?
  end
end
