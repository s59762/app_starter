class Admin::ProductForm < ApplicationForm
  VALID_PRICE_ATTRIBUTES = %w(original sell discounted).freeze
  model Product

  properties :name,
             :description,
             :brand_id,
             :cover,
             :is_preorder,
             :properties,
             :width,
             :depth,
             :height,
             :weight
  property :price, virtual: true
  property :top_level_category_id, virtual: true
  property :sub_category_id, virtual: true
  property :uploaded_image_ids, virtual: true
  property :option_types, virtual: true

  validates :name,
            :top_level_category_id,
            :description, presence: true
  validate :valid_price_params?
  validate :valid_option_types?

  # 將資料寫入 Product
  #
  # @return [Bollean] 回傳是否成功寫入 DB
  def save
    description_image_ids = description.scan(/\/uploads\/product\/image\/image\/([0-9]+)/).flatten.map(&:to_i)
    @is_new_record = model.new_record?

    sync
    assign_price_info_to_model
    assign_category_to_model

    ::ActiveRecord::Base.transaction do
      model.save
      link_product_images(description_image_ids)
      delete_unused_images(description_image_ids)
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
    Product::Image.where(id: description_image_ids).each do |image|
      image.update product_id: model.id
    end
  end

  # 刪除 description 編輯後不再需要的圖片
  def delete_unused_images(description_image_ids)
    current_description_image_ids = model.description_images.select(:id).map(&:id) # 目前與 product 有關聯的 description 圖片
    unused_image_ids = uploaded_image_ids + current_description_image_ids - description_image_ids

    Product::Image.where(id: unused_image_ids).destroy_all
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
      type.option_values.map { |v| { id: v.id, name: %(#{type.name} - #{v.value}) } }
    end
    all_option_combinations = options[0].product(*options[1..-1])

    all_option_combinations.each_with_index do |option_combination, index|
      is_master = (index == 0)

      model.variants.create name: option_combination.map { |option| option[:name] }.join(', '),
                            original_price: model.original_price,
                            sell_price: model.sell_price,
                            discounted_price: model.discounted_price,
                            weight: model.weight,
                            width: model.width,
                            depth: model.depth,
                            height: model.height,
                            is_master: is_master
    end
  end

  def build_default_master_variant
    model.master.update original_price: model.original_price,
                        sell_price: model.sell_price,
                        discounted_price: model.discounted_price,
                        weight: model.weight,
                        width: model.width,
                        depth: model.depth,
                        height: model.height
  end
end
