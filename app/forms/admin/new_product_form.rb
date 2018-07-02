class Admin::NewProductForm < ApplicationForm
  VALID_PRICE_ATTRIBUTES = %w(original sell discounted).freeze
  model Product

  properties :name,
             :properties,
             :brand_id
  property :sku, virtual: true
  property :price, virtual: true
  property :width, virtual: true
  property :depth, virtual: true
  property :height, virtual: true
  property :weight, virtual: true
  property :top_level_category_id, virtual: true
  property :sub_category_id, virtual: true
  property :option_types, virtual: true

  validates :name,
            :top_level_category_id, presence: true
  validate :valid_price_params?
  validate :valid_option_types?

  # 將資料寫入 Product
  #
  # @return [Bollean] 回傳是否成功寫入 DB
  def save
    @is_new_record = model.new_record?

    sync
    # assign_price_info_to_model
    assign_category_to_model

    ::ActiveRecord::Base.transaction do
      model.save
      process_option_types
      process_variants
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

  # 驗證 option_types 的內容是否合法
  def valid_option_types?
    return if option_types.blank?
    option_types.each do |type|
      errors.add(:option_types, :type_name_blank) if type['name'].blank?

      type['options'].each do |option|
        errors.add(:option_types, :option_value_blank) if option['value'].blank?
      end
    end
  end

  private

  def assign_category_to_model
    id = sub_category_id.present? ? sub_category_id : top_level_category_id

    model.assign_attributes category_id: id
  end

  def process_option_types
    return unless @is_new_record

    option_types.each do |type|
      option_type = model.option_types.create name: type['name']

      type['options'].each do |option|
        option_type.option_values.create value: option['value']
      end
    end
  end

  def process_variants
    return unless @is_new_record
    return build_default_master_variant if model.option_types.blank?

    options = model.option_types.map do |type|
      type.option_values.map { |v| { id: v.id, name: v.value } }
    end
    all_option_combinations = options[0].product(*options[1..-1])

    all_option_combinations.each_with_index do |option_combination, index|
      is_master = (index == 0)

      model.variants.create name: option_combination.map { |option| option[:name] }.join('-'),
                            sku: "#{sku}-#{index}",
                            original_price: price['original'],
                            sell_price: price['sell'],
                            discounted_price: price['discounted'],
                            width: width,
                            depth: depth,
                            height: height,
                            weight: weight,
                            is_master: is_master
    end
  end

  def build_default_master_variant
    model.master.update sku: sku,
                        original_price: price['original'],
                        sell_price: price['sell'],
                        discounted_price: price['discounted'],
                        width: width,
                        depth: depth,
                        height: height,
                        weight: weight
  end
end
