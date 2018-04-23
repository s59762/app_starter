class Admin::ProductForm < ApplicationForm
  VALID_PRICE_ATTRIBUTES = %w(original sell discounted).freeze
  model Product

  properties :name,
             :description,
             :category_id,
             :cover,
             :is_preorder,
             :properties
  property :price, virtual: true

  validates :name,
            :description, presence: true
  validate :valid_price_params?

  # 將資料寫入 Product
  #
  # @return [Bollean] 回傳是否成功寫入 DB
  def save
    description_image_ids = description.scan(/\/uploads\/product\/image\/image\/([0-9]+)/).flatten.map(&:to_i)

    sync
    assign_price_info_to_model

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

  def link_product_images(ids)
    Product::Image.where(id: ids).each do |image|
      image.update product_id: model.id
    end
  end

  def delete_unused_images(new_ids)
    current_ids = model.description_images.select(:id).map(&:id)
    Product::Image.where(id: current_ids - new_ids).destroy_all
    Product::Image.where(product_id: nil).destroy_all
  end
end
