class Admin::EditProductForm < ApplicationForm
  VALID_PRICE_ATTRIBUTES = %w(original sell discounted).freeze
  model Product

  properties :name,
             :description,
             :brand_id,
             :is_preorder,
             :properties,
             :meta_title,
             :meta_description,
             :meta_keywords
  property :price, virtual: true
  property :top_level_category_id, virtual: true
  property :sub_category_id, virtual: true
  property :uploaded_image_ids, virtual: true

  validates :name,
            :top_level_category_id, presence: true
  validate :valid_price_params?

  # 將資料寫入 Product
  #
  # @return [Bollean] 回傳是否成功寫入 DB
  def save
    description_image_ids = description.present? ? description.scan(/\/uploads\/product\/image\/image\/([0-9]+)/).flatten.map(&:to_i) : []

    sync
    # assign_price_info_to_model
    assign_category_to_model

    ::ActiveRecord::Base.transaction do
      model.save
      link_product_images(description_image_ids)
      delete_unused_images(description_image_ids)
    end
  end

  # 驗證 price 的內容是否合法
  def valid_price_params?
    price.each do |key, value|
      errors.add(:price, :invalid_key, key: key) unless VALID_PRICE_ATTRIBUTES.include?(key)
      errors.add(:price, :wrong_type, key: key) unless value.class.name == 'Integer' && value >= 0
    end

    errors.add('price', :invalid_discounted_price) if price['discounted'] > price['sell']
  end

  private

  # 把 price 的內容指定到 model 中
  def assign_price_info_to_model
    price.each do |key, value|
      model.assign_attributes "#{key}_price".to_sym => value
    end
  end

  def assign_category_to_model
      id = sub_category_id.present? ? sub_category_id : top_level_category_id

      model.assign_attributes category_id: id
  end

  # 將有出現在 description 中的圖片與此 product 建立關聯
  def link_product_images(description_image_ids)
    return unless description_image_ids

    Product::Image.where(id: description_image_ids).each do |image|
      image.update product_id: model.id
    end
  end

  # 刪除 description 編輯後不再需要的圖片
  def delete_unused_images(description_image_ids)
    return unless description_image_ids

    current_description_image_ids = model.description_images.select(:id).map(&:id) # 目前與 product 有關聯的 description 圖片
    unused_image_ids = uploaded_image_ids + current_description_image_ids - description_image_ids

    Product::Image.where(id: unused_image_ids).destroy_all
  end
end
