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
  property :uploaded_attachment_ids, virtual: true

  validates :name,
            :top_level_category_id, presence: true
  validate :valid_price_params?

  # 將資料寫入 Product
  #
  # @return [Bollean] 回傳是否成功寫入 DB
  def save
    attachment_ids = description.present? ? description.scan(/\/uploads\/editor_attachment\/file\/([0-9]+)/).flatten.map(&:to_i) : []

    sync
    assign_category_to_model

    ::ActiveRecord::Base.transaction do
      model.save
      model.process_uploaded_attachments(attachment_ids, uploaded_attachment_ids: uploaded_attachment_ids)
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

  def assign_category_to_model
    id = sub_category_id || top_level_category_id

    model.assign_attributes category_id: id
  end
end
