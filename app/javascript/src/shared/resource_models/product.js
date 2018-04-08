import axios from 'axios'
import FetchingDataOptionsService from '../services/fetching_data_options_service'

const API_PATH = '/api'
const API_VERSION = 'v1'
const SCOPE = 'web'
const RESOURCE_TYPE = 'products'
const API_BASE_PATH = `${API_PATH}/${API_VERSION}/${SCOPE}/${RESOURCE_TYPE}`
const ATTRIBUTES = [
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
]
const EDITABLE_ATTRIBUTES = ['cover', 'description', 'price', 'is_preorder', 'name', 'properties', 'image_ids']

export default class Product {
  constructor(attributes = {}) {
    ATTRIBUTES.forEach(attr => {
      this[attr] = attributes[attr] || null
    })
  }

  /**
   * 對 API 送出請求，拿回 resources 的 list
   *
   * @returns {Promise} 回傳 response 或 errors
   */
  static all(options = {}) {
    return axios.get(`${API_BASE_PATH}?${FetchingDataOptionsService.call(options)}`)
  }

  /**
   * 對 API 送出請求，拿回單一 resource 的內容
   *
   * @param {number} id 指定的 resource ID
   * @returns {Promise} 回傳 response 或 errors
   */
  static find(id, options = {}) {
    return axios.get(`${API_BASE_PATH}/${id}?${FetchingDataOptionsService.call(options)}`)
  }

  static uploadImages(formData) {
    return axios.post(`${API_BASE_PATH}/images`, formData)
  }

  /**
   * 把目前的 resource 內容存到 server。
   *
   * @returns {Promise} 回傳 response 或 errors
   */
  save() {
    if (this.isNewRecord()) {
      return axios.post(API_BASE_PATH, this.requestBody())
    } else {
      return axios.put(`${API_BASE_PATH}/${this.id}`, this.requestBody())
    }
  }

  static update(id, resource) {
    return axios.put(`${API_BASE_PATH}/${id}`, resource)
  }

  /**
   * 刪除目前的 resource
   *
   * @returns {Promise} 回傳 response 或 errors
   */
  destroy() {
    return axios.delete(`${API_BASE_PATH}/${this.id}`)
  }

  /**
   *  Helpers
   */
  attributes(options = {}) {
    let result = {}

    if (options.all) {
      ATTRIBUTES.forEach(attr => {
        result[attr] = this[attr]
      })
    } else {
      EDITABLE_ATTRIBUTES.forEach(attr => {
        result[attr] = this[attr] || null
      })
    }

    return result
  }

  isNewRecord() {
    return this.id === null
  }

  requestBody() {
    const priceColumns = ['original', 'sell', 'discounted']

    priceColumns.forEach(element => {
      this.price[element] = parseInt(this.price[element])
    })

    return {
      data: {
        type: RESOURCE_TYPE,
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
