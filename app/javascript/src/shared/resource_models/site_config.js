import axios from 'axios'

const API_PATH = '/api'
const API_VERSION = 'v1'
const SCOPE = 'web'
const RESOURCE_TYPE = 'site_config'
const API_BASE_PATH = `${API_PATH}/${API_VERSION}/${SCOPE}/${RESOURCE_TYPE}`
const ATTRIBUTES = ['meta_tags']
const EDITABLE_ATTRIBUTES = ['meta_tags']

export default class SiteConfig {
  constructor(attributes = {}) {
    ATTRIBUTES.forEach(attr => {
      this[attr] = attributes[attr] || null
    })
  }
  /**
   * 對 API 送出請求，拿回 site configs
   *
   * @returns {Promise} 回傳 response 或 errors
   */
  static all() {
    return axios.get(`${API_BASE_PATH}`)
  }

  /**
   * 對 API 送出請求，更新 MetaTags 設定
   *
   * @returns {Promise} 回傳 response 或 errors
   */
  updateMetaTags() {
    return axios.put(`${API_BASE_PATH}/meta_tags`, this.metaTagsRequestBody())
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

  metaTagsRequestBody() {
    return {
      data: {
        type: RESOURCE_TYPE,
        attributes: this.meta_tags
      }
    }
  }
}
