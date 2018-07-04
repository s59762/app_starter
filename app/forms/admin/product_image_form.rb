class Admin::ProductImageForm < ApplicationForm
  model Product::Image

  VALID_USE_CASES = %w(
    normal
    description
  ).freeze

  property :images, virtual: true
  properties :use_case, :product_id

  validate :valid_use_case?
  validate :valid_images_content?

  # 將資料寫入 Product::Image
  #
  # @return [Bollean] 回傳是否成功寫入 DB
  def save
    ::ActiveRecord::Base.transaction do
      images.each do |file|
        new_image = Product::Image.create image: file, use_case: use_case, product_id: product_id
        created_image_ids << new_image.id
      end
    end
  end

  def created_image_ids
    @created_image_ids ||= []
  end

  def valid_use_case?
    errors.add(:use_case, :invalid_value, value: use_case.to_s) unless VALID_USE_CASES.include?(use_case)
  end

  def valid_images_content?
    errors.add(:images, :blank) if images.blank?
  end
end
