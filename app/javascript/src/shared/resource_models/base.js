import axios from 'axios'
import Vue from 'vue/dist/vue.esm'
import FetchingDataOptionsService from '../services/fetching_data_options_service'

/**
 * Model 層的基礎，包含了所有 Models 都會用到的方法
 *
 * @export
 * @class ModelBase
 */
export default class ModelBase {
  /**
   * Creates an instance of ModelBase.
   * @param {Object} options 接受額外的選項，這邊可以接受 resource_type 來指定 model 在 API 中的 type
   * @memberof ModelBase
   */
  constructor(options) {
    this.api_base_path = options.api_base_path || '/api'
    this.api_version = options.api_version || 'v1'
    this.scope = options.scope || 'web'
    this.resource_type = options.resource_type
  }

  /**
   * 對 API 送出請求，拿回 resources 的 list
   *
   * @returns {Promise} 回傳 response 或 errors
   * @memberof ModelBase
   */
  index(options = {}) {
    return axios.get(
      `${this.api_base_path}/${this.api_version}/${this.scope}/${
        this.resource_type
      }?${FetchingDataOptionsService.pagenate(options)}${FetchingDataOptionsService.sort(
        options
      )}${FetchingDataOptionsService.filter(options)}${FetchingDataOptionsService.search(options)}`
    )
  }

  /**
   * 對 API 送出請求，拿回單一 resource 的內容
   *
   * @param {number} id 指定的 resource ID
   * @returns {Promise} 回傳 response 或 errors
   * @memberof ModelBase
   */
  show(id, options = {}) {
    return axios.get(`${this.api_base_path}/${this.api_version}/${this.scope}/${this.resource_type}/${id}`)
  }

  /**
   * 對 API 送出請求，建立一筆新的 resource 紀錄
   *
   * @param {object} resource 符合 JSON-API 規範的 request body
   * @returns {Promise} 回傳 response 或 errors
   * @memberof ModelBase
   */
  create(resource) {
    return axios.post(`${this.api_base_path}/${this.api_version}/${this.scope}/${this.resource_type}`, resource)
  }

  /**
   * 對 API 送出請求，更新一筆已經存在的 resource
   *
   * @param {number} id 指定的 resource ID
   * @param {object} resource 符合 JSON-API 規範的 request body
   * @returns {Promise} 回傳 response 或 errors
   * @memberof ModelBase
   */
  update(id, resource) {
    return axios.put(`${this.api_base_path}/${this.api_version}/${this.scope}/${this.resource_type}/${id}`, resource)
  }

  /**
   * 對 API 送出請求，刪除一筆已經存在的 resource
   *
   * @param {any} id
   * @returns {Promise} 回傳 response 或 errors
   * @memberof ModelBase
   */
  destroy(id) {
    return axios.delete(`${this.api_base_path}/${this.api_version}/${this.scope}/${this.resource_type}/${id}`)
  }
}
