import axios from 'axios'
import Vue from 'vue/dist/vue.esm'
import normalize from 'jsonapi-normalizer'
import merge from 'lodash.merge'

const DEFAULT_PAGE_SIZE = 25
let pagenateOptions = function(options) {
  let pageNumber = options.pageNumber
  let pageSize = options.pageSize || DEFAULT_PAGE_SIZE

  if (pageNumber) {
    return `page[number]=${pageNumber}&page[size]=${pageSize}`
  } else {
    return ''
  }
}

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
    this.api_base_path = '/api'
    this.api_version = 'v1'
    this.scope = 'web'
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
      }?${pagenateOptions(options)}`
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
    return axios.get(
      `${this.api_base_path}/${this.api_version}/${this.scope}/${this.resource_type}/${id}`
    )
  }

  /**
   * 對 API 送出請求，建立一筆新的 resource 紀錄
   *
   * @param {object} resource 符合 JSON-API 規範的 request body
   * @returns {Promise} 回傳 response 或 errors
   * @memberof ModelBase
   */
  create(resource) {
    return axios.post(
      `${this.api_base_path}/${this.api_version}/${this.scope}/${this.resource_type}`,
      resource
    )
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
    return axios.put(
      `${this.api_base_path}/${this.api_version}/${this.scope}/${this.resource_type}/${id}`,
      resource
    )
  }

  /**
   * 對 API 送出請求，刪除一筆已經存在的 resource
   *
   * @param {any} id
   * @returns {Promise} 回傳 response 或 errors
   * @memberof ModelBase
   */
  destroy(id) {
    return axios.delete(
      `${this.api_base_path}/${this.api_version}/${this.scope}/${this.resource_type}/${id}`
    )
  }

  // ------------------------------------------------------------------------ //
  // --------------------------- For Mutations ------------------------------ //
  // ------------------------------------------------------------------------ //

  /**
   * 把 response 中的所有 resources 內容放到 vuex store 中
   *
   * @param {object} state vuex state
   * @param {object} response raw response from server
   * @memberof ModelBase
   */
  storeResourcesToEntities(state, response) {
    const normalizedResult = normalize(response.data)

    state.entities = merge({}, state.entities, normalizedResult.entities[this.resource_type])
    state.result = merge([], state.result, normalizedResult.result[this.resource_type])
  }

  /**
   * 把單筆 resource 內容放到 vuex store 中
   *
   * @param {object} state vuex state
   * @param {object} response raw response from server
   * @memberof ModelBase
   */
  storeOneResourceToEntities(state, response) {
    const normalizedResult = normalize(response.data)
    const id = Object.keys(normalizedResult.entities[this.resource_type])[0]

    Vue.set(state.entities, id, normalizedResult.entities[this.resource_type][id])
  }

  /**
   * 把單筆 resource 從 vuex store 移除
   *
   * @param {object} state vuex state
   * @param {object} id resource ID
   * @memberof ModelBase
   */
  removeOneResourceFromEntities(state, id) {
    const index = state.result.indexOf(id)

    Vue.delete(state.entities, id)
    state.result.splice(index, 1)
  }

  /**
   * 把單筆 resource ID 放到 vuex store 的 result 最前面
   *
   * @param {object} state vuex state
   * @param {object} response raw response from server
   * @memberof ModelBase
   */
  unshiftResourceToResult(state, response) {
    const normalizedResult = normalize(response.data)
    const id = Object.keys(normalizedResult.entities[this.resource_type])[0]

    state.result.unshift(id)
  }

  /**
   * 把單筆 resource ID 放到 vuex store 的 result 最後面
   *
   * @param {object} state vuex state
   * @param {object} response raw response from server
   * @memberof ModelBase
   */
  pushResourceToResult(state, response) {
    const normalizedResult = normalize(response.data)
    const id = Object.keys(normalizedResult.entities[this.resource_type])[0]

    state.result.push(id)
  }
}
