import axios from 'axios'
import FetchingDataOptionsService from 'odd-fetching_data_options_service'
import ResourceModelBase from 'odd-resource_model'

const OPTIONS = {
  apiPath: '/api',
  apiVersion: 'v1',
  scope: 'web',
  resourceType: 'products',
  attributes: [
    'brand_id',
    'category_id',
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
    'updated_at'
  ],
  editableAttributes: [
    'brand_id',
    'category_id',
    'cover',
    'description',
    'is_preorder',
    'name',
    'price',
    'properties',
    'uploaded_image_ids'
  ]
}

export default class Product extends ResourceModelBase {
  constructor(attributes = {}) {
    super(OPTIONS, attributes)
  }

  static uploadImages(formData) {
    return axios.post(`${new this().apiBasePath()}/images`, formData)
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
    return `${this[`${price}_price`] / 100} ${I18n.t('activerecord.attributes.product.price_unit')}`
  }
}
