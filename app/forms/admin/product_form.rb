class Admin::ProductForm < ApplicationForm
  VALID_PRICE_ATTRIBUTES = %w[original sell discounted]
  model Product

  properties :name,
             :description,
             :category_id,
             :cover,
             :is_preorder,
             :properties
  property :price, virtual: true

  validates :name, presence: true
  validate :valid_price_params?

  # 將資料寫入 Product
  #
  # @return [Bollean] 回傳是否成功寫入 DB
  def save
    sync
    assign_price_info_to_model
    super
  end

  # 驗證 price 的內容是否合法
  def valid_price_params?
    price.each do |key, value|
      errors.add(:price, :invalid_key, { key: key }) unless VALID_PRICE_ATTRIBUTES.include?(key)
      errors.add(:price, :wrong_type, { key: key }) unless value.class.name == 'Integer' && value >= 0
    end
  end

  private

  # 把 price 的內容指定到 model 中
  def assign_price_info_to_model
    price.each do |key, value|
      model.assign_attributes "#{key}_price".to_sym => value
    end
  end
end
