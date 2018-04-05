import normalize from 'jsonapi-normalizer'
import merge from 'lodash.merge'

/**
 * 若 server response 包含 meta Object 的話，一併存到 vuex module 中
 *
 * @param {object} state Vuex state 物件
 * @param {object} response axios 從 server 拿到的 response 物件
 */
const tryStoreMetaToVuex = function(state, response) {
  const metaObj = response.data.meta

  if (metaObj) {
    state.meta = merge({}, state.meta, metaObj)
  }
}

/**
 * Vuex Mutation 中會使用到的方法集合
 *
 * @export
 * @class MutationHelpers
 */
export default class MutationHelpers {
  /**
   * Creates an instance of MutationHelpers.
   *
   * @param {string} resource_type JSON:API 格式中的 resource type
   * @memberof MutationHelpers
   */
  constructor(resource_type) {
    this.resource_type = resource_type
  }

  /**
   * 把 response 中的所有 resources 內容加入 vuex store 中
   * 這通常用是在把 JSON:API 中的 includes 內容放到相應的 vuex module 時使用
   *
   * @param {object} state vuex state
   * @param {object} response raw response from server
   * @memberof ModelBase
   */
  storeResourcesToEntities(state, response) {
    const normalizedResult = normalize(response.data)

    tryStoreMetaToVuex(state, response)
    state.entities = merge({}, state.entities, normalizedResult.entities[this.resource_type])
    state.result = merge([], state.result, normalizedResult.result[this.resource_type])
  }

  /**
   * 清除原本 vuex store 的內容把 response 中的所有 resources 內容放到 vuex store 中
   * 這通常會用在 index action 中（`allResource`）
   *
   * @param {object} state vuex state
   * @param {object} response raw response from server
   * @memberof ModelBase
   */
  replaceEntities(state, response) {
    const normalizedResult = normalize(response.data)

    tryStoreMetaToVuex(state, response)
    state.entities = normalizedResult.entities[this.resource_type] || {}
    state.result = normalizedResult.result[this.resource_type] || []
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

    tryStoreMetaToVuex(state, response)
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

  /**
   * 僅用於把 site config 的內容放到 vuex 時使用。因為這並不是標準 JSON:API 格式
   *
   * @param {any} state
   * @param {any} response
   * @memberof MutationHelpers
   */
  storeSiteConfigs(state, response) {
    const result = response.data

    state.configs = result
  }

  /**
   * 把 admin roles 列表寫入 vuex store。
   */
  receiveAvailableRoles(state, response) {
    state.availableRoles = response.data.data
  }
}
