import axios from 'axios'
import FetchingDataOptionsService from 'odd-fetching_data_options_service'
import ResourceModelBase from 'odd-resource_model'

const OPTIONS = {
  apiPath: '/api',
  apiVersion: 'v1',
  scope: 'web',
  resourceType: 'products',
  attributes: [
    'id',
    'cover',
    'description',
    'discounted_price',
    'is_preorder',
    'name',
    'original_price',
    'properties',
    'sell_price',
    'created_at',
    'discount_rate'
  ],
  editableAttributes: ['cover', 'description', 'price', 'is_preorder', 'name', 'properties']
}

export default class Product extends ResourceModelBase {
  constructor(attributes = {}) {
    super(OPTIONS, attributes)
  }

  static uploadImages(formData) {
    return axios.post(`${new this().apiBasePath()}/images`, formData)
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
    const rateNumber = this.discount_rate
      .toFixed(2)
      .toString()
      .split('.')[1]

    return `${rateNumber} ${I18n.t('activerecord.attributes.product.discount_unit')}`
  }

  displayPrice(price) {
    let rawValue = 0

    switch (price) {
      case 'original':
        rawValue = this.original_price
        break
      case 'sell':
        rawValue = this.sell_price
        break
      case 'discounted':
        rawValue = this.discounted_price
        break
      default:
        rawValue = this.sell_price
        break
    }

    return `${rawValue / 100} ${I18n.t('activerecord.attributes.product.price_unit')}`
  }
}
