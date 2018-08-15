class Admin::ProductVariantForm < ApplicationForm
  VALID_PRICE_ATTRIBUTES = %w(original sell discounted).freeze

  model Product::Variant

  properties :name,
             :sku,
             :weight,
             :width,
             :depth,
             :height,
             :description,
             :option_value_ids
  property :price, virtual: true

  validates :sku, presence: true
  validate :valid_price_params?

  # 將資料寫入 Product
  #
  # @return [Bollean] 回傳是否成功寫入 DB
  def save
    @is_new_record = model.new_record?

    sync
    assign_price_info_to_model
    normalizing_option_value_ids

    model.save
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

  def assign_price_info_to_model
    price.each do |key, value|
      model.assign_attributes "#{key}_price".to_sym => value
    end
  end

  def normalizing_option_value_ids
    option_value_ids.map!(&:to_i)
  end
end
