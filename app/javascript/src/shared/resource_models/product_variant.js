import axios from 'axios'
import ResourceModelBase from 'odd-resource_model'

const OPTIONS = {
  apiPath: '/api',
  apiVersion: 'v1',
  scope: 'web',
  resourceType: 'product_variants',
  attributes: [
    'id',
    'name',
    'sku',
    'original_price',
    'sell_price',
    'discounted_price',
    'weight',
    'width',
    'depth',
    'height',
    'is_master',
    'description',
    'product_id',
    'option_value_ids',
    'stock'
  ],
  editableAttributes: [
    'name',
    'sku',
    'price',
    'weight',
    'width',
    'depth',
    'height',
    'description',
    'stock_params'
  ]
}

export default class ProductVariant extends ResourceModelBase {
  constructor(attributes = {}) {
    super(OPTIONS, attributes)
  }

  setAsMaster() {
    return axios.put(`${this.apiBasePath()}/${this.id}/set_as_master`)
  }

  updateStock() {
    const requestBody = {
      data: {
        type: 'update-product-variant-stock',
        attributes: {
          quantity: this.stock_params.quantity,
          action: this.stock_params.action,
          reason: this.stock_params.reason
        }
      }
    }

    return axios.put(`${this.apiBasePath()}/${this.id}/stock`, requestBody)
  }

  // extra methods or helpers here...
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

  displayPrice(price = 'sell') {
    if (this[`${price}_price`] === 0) return I18n.t('messages.data_not_provided')

    return `${this[`${price}_price`] / 100} ${I18n.t('activerecord.attributes.product.price_unit')}`
  }

  displayDiscountRate() {
    let rateNumber = this.discount_rate
      .toFixed(2)
      .toString()
      .split('.')[1]

    if (rateNumber.slice(-1) === '0') rateNumber = rateNumber.substr(0, 1)

    return `${rateNumber} ${I18n.t('activerecord.attributes.product.discount_unit')}`
  }

  displaySize() {
    const properties = ['width', 'depth', 'height']
    let result = []

    properties.forEach(property => {
      if (this[property]) result.push(`${I18n.t(`activerecord.attributes.product.${property}`)} ${this[property]}`)
    })

    if (result.length > 0) {
      return result.join(' × ')
    } else {
      return I18n.t('messages.data_not_provided')
    }
  }
}
