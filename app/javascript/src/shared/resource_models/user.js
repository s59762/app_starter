import axios from 'axios'
import FetchingDataOptionsService from '../services/fetching_data_options_service'

const API_PATH = '/api'
const API_VERSION = 'v1'
const SCOPE = 'web'
const RESOURCE_TYPE = 'users'
const API_BASE_PATH = `${API_PATH}/${API_VERSION}/${SCOPE}/${RESOURCE_TYPE}`
const ATTRIBUTES = ['created_at', 'email', 'id', 'last_sign_in_at', 'sign_in_count', 'updated_at']
const EDITABLE_ATTRIBUTES = ['email', 'new_password', 'password', 'password_confirmation']

export default class User {
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
        result[attr] = this[attr]
      })
    }

    return result
  }

  isNewRecord() {
    return this.id === null
  }

  requestBody() {
    return {
      data: {
        type: RESOURCE_TYPE,
        attributes: this.attributes()
      }
    }
  }
}
