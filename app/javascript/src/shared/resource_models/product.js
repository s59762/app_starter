import axios from 'axios'
import ResourceModelBase from 'odd-resource_model'

const OPTIONS = {
  apiPath: '/api',
  apiVersion: 'v1',
  scope: 'web',
  resourceType: 'products',
  attributes: [
    'brand_id',
    'brand_name',
    'category',
    'top_level_category_id',
    'sub_category_id',
    'cover',
    'created_at',
    'description',
    'discount_rate',
    'discounted_price',
    'id',
    'is_preorder',
    'name',
    'original_price',
    'properties',
    'sell_price',
    'updated_at',
    'width',
    'depth',
    'height',
    'weight',
    'sku',
    'master',
    'variants',
    'options',
    'meta_title',
    'meta_description',
    'meta_keywords',
    'total_stock',
    'images'
  ],
  editableAttributes: [
    'brand_id',
    'top_level_category_id',
    'sub_category_id',
    'description',
    'is_preorder',
    'name',
    'price',
    'properties',
    'option_types',
    'uploaded_attachment_ids',
    'width',
    'depth',
    'height',
    'weight',
    'sku',
    'meta_title',
    'meta_description',
    'meta_keywords'
  ]
}

export default class Product extends ResourceModelBase {
  constructor(attributes = {}) {
    super(OPTIONS, attributes)
  }

  static uploadImages(formData) {
    return axios.post(`${new this().apiBasePath()}/images`, formData)
  }

  static uploadAttachments(formData) {
    return axios.post(`${new this().apiBasePath({ withResourceType: false })}/editor_attachments`, formData)
  }

  // helpers

  hasDiscount() {
    return this.discount_rate < 1
  }

  requestBody() {
    const priceColumns = ['original', 'sell', 'discounted']

    // Price columns must be [Number]
    priceColumns.forEach(element => {
      this.price[element] = parseInt(this.price[element])
    })

    return {
      data: {
        type: OPTIONS.resourceType,
        attributes: this.attributes()
      }
    }
  }

  displayDiscountRate() {
    let rateNumber = this.discount_rate
      .toFixed(2)
      .toString()
      .split('.')[1]

    if (rateNumber.slice(-1) === '0') rateNumber = rateNumber.substr(0, 1)

    return `${rateNumber} ${I18n.t('activerecord.attributes.product.discount_unit')}`
  }

  displayPrice(price = 'sell') {
    if (this[`${price}_price`] === 0) return I18n.t('messages.data_not_provided')

    return `${this[`${price}_price`] / 100}`
  }

  displaySize() {
    const properties = ['width', 'depth', 'height']
    let result = []

    properties.forEach(property => {
      if (this[property]) result.push(`${I18n.t(`activerecord.attributes.product.${property}`)} ${this[property]}`)
    })

    return result.join(' × ')
  }

  hasVariants() {
    return this.variants.length > 0
  }

  coverImageThumb() {
    if (this.cover) return this.cover.square.url

    return 'https://via.placeholder.com/512x512?text=No+Image'
  }

  hasDiscount() {
    return this.discounted_price !== 0
  }
}
