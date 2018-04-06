import * as types from './mutation-types'
import ProductCategory from '../../resource_models/product_category'

/**
 * 從 Server 取得所有 Resource
 *
 * @param {object} options 可傳入 paginate options 或其他 filter 功能。
 *
 * @returns {promise} response or errors
 */
export const all = ({ dispatch, commit }, options) => {
  commit(types.FETCH_PRODUCT_CATEGORIES_START)

  return new Promise((resolve, reject) => {
    ProductCategory.all(options)
      .then(response => {
        commit(types.FETCH_PRODUCT_CATEGORIES_SUCCESS, response)

        resolve(response)
      })
      .catch(errors => {
        commit(types.API_REQUEST_FAIL, errors)
        dispatch('errorMessageHandler', errors, { root: true })

        reject(errors)
      })
  })
}

/**
 * 從 Server 取得一個特定 Resource
 *
 * @param {number} id 指定的 resource ID
 * @returns {promise} response or errors
 */
export const find = ({ dispatch, commit }, id) => {
  commit(types.GET_PRODUCT_CATEGORY_START)

  return new Promise((resolve, reject) => {
    ProductCategory.find(id)
      .then(response => {
        commit(types.GET_PRODUCT_CATEGORY_SUCCESS, response)

        resolve(response)
      })
      .catch(errors => {
        commit(types.API_REQUEST_FAIL, errors)
        dispatch('errorMessageHandler', errors, { root: true })

        reject(errors)
      })
  })
}

/**
 * 新增 Resource 到 Server
 *
 * @param {object} resource JSON:API 規格的 request body
 * @returns {promise} response or errors
 */
export const create = ({ dispatch, commit }, model) => {
  commit(types.ADD_PRODUCT_CATEGORY_START)

  return new Promise((resolve, reject) => {
    model
      .save()
      .then(response => {
        commit(types.ADD_PRODUCT_CATEGORY_SUCCESS, response)

        resolve(response)
      })
      .catch(errors => {
        commit(types.API_REQUEST_FAIL, errors)
        dispatch('errorMessageHandler', errors, { root: true })

        reject(errors)
      })
  })
}

/**
 * 從 Server 更新一筆 resource 的內容
 *
 * @param {number} id 指定的 resource ID
 * @param {object} resource JSON:API 規格的 request body
 * @returns {promise} response or errors
 */
export const update = ({ dispatch, commit }, model) => {
  commit(types.UPDATE_PRODUCT_CATEGORY_START)

  return new Promise((resolve, reject) => {
    model
      .save()
      .then(response => {
        commit(types.UPDATE_PRODUCT_CATEGORY_SUCCESS, response)

        resolve(response)
      })
      .catch(errors => {
        commit(types.API_REQUEST_FAIL, errors)
        dispatch('errorMessageHandler', errors, { root: true })

        reject(errors)
      })
  })
}

/**
 * 從 Server 刪除一筆 resource
 *
 * @param {number} id 指定的 resource ID
 * @returns {promise} response or errors
 */
export const destroy = ({ dispatch, commit }, model) => {
  commit(types.DELETE_PRODUCT_CATEGORY_START)

  return new Promise((resolve, reject) => {
    model
      .destroy()
      .then(response => {
        commit(types.DELETE_PRODUCT_CATEGORY_SUCCESS, model.id)

        resolve(response)
      })
      .catch(errors => {
        commit(types.API_REQUEST_FAIL, errors)
        dispatch('errorMessageHandler', errors, { root: true })

        reject(errors)
      })
  })
}

/**
 * 收到多筆其他 resource 的 relationships
 *
 * @param {object} response axios response object
 * @returns {promise} response or errors
 */
export const receiveResourcesFromRelationships = ({ commit }, response) => {
  return new Promise((resolve, reject) => {
    commit(types.GET_RELATED_PRODUCT_CATEGORIES_SUCCESS, response)

    resolve(response)
  })
}

/**
 * 收到單筆其他 resource 的 relationship
 *
 * @param {object} response axios response object
 * @returns {promise} response or errors
 */
export const getResourceFromRelationship = ({ commit }, response) => {
  return new Promise((resolve, reject) => {
    commit(types.GET_PRODUCT_CATEGORY_SUCCESS, response)

    resolve(response)
  })
}
