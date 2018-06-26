class User::ShippingInfoForm < ApplicationForm
  model User::ShippingInfo

  properties :recipient,
             :phone,
             :address

  validates :recipient,
            :phone,
            :address, presence: true

  validate :valid_address_detail?

  # 將資料寫入 ModelName
  #
  # @return [Bollean] 回傳是否成功寫入 DB
  # def save
  #   super
  # end

  def valid_address_detail?
    errors[:address] << I18n.t('activerecord.errors.models.user/shipping_info.attributes.address.detail_blank', { attribute: User::ShippingInfo.human_attribute_name(:country) }) if address['country'].blank?
    errors[:address] << I18n.t('activerecord.errors.models.user/shipping_info.attributes.address.detail_blank', { attribute: User::ShippingInfo.human_attribute_name(:city) }) if address['city'].blank?
    errors[:address] << I18n.t('activerecord.errors.models.user/shipping_info.attributes.address.detail_blank', { attribute: User::ShippingInfo.human_attribute_name(:street_address) }) if address['street_address'].blank?
    errors[:address] << I18n.t('activerecord.errors.models.user/shipping_info.attributes.address.detail_blank', { attribute: User::ShippingInfo.human_attribute_name(:zip) }) if address['zip'].blank?
  end
end
