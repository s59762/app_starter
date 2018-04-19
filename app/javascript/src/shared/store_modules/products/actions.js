import * as types from './mutation-types'
import Product from '../../resource_models/product'

/**
 * 從 Server 取得所有 Resource
 *
 * @param {object} options 可傳入 paginate options 或其他 filter 功能。
 *
 * @returns {promise} response or errors
 */
export const all = ({ dispatch, commit }, options) => {
  commit(types.API_REQUEST_START, 'all')

  return new Promise((resolve, reject) => {
    Product.all(options)
      .then(response => {
        commit(types.FETCH_PRODUCTS_SUCCESS, response)

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
  commit(types.API_REQUEST_START, 'find')

  return new Promise((resolve, reject) => {
    Product.find(id)
      .then(response => {
        commit(types.GET_PRODUCT_SUCCESS, response)

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
 * Upload Images for product description
 *
 * @returns {promise} response or errors
 */
export const uploadImages = ({ dispatch, commit }, formData) => {
  commit(types.API_REQUEST_START, 'uploadImages')

  return new Promise((resolve, reject) => {
    Product.uploadImages(formData)
      .then(response => {
        commit(types.PRODUCT_IMAGE_UPLOAD_SUCCESS, response)

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
  commit(types.API_REQUEST_START, 'create')

  return new Promise((resolve, reject) => {
    model
      .save()
      .then(response => {
        commit(types.ADD_PRODUCT_SUCCESS, response)

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
  commit(types.API_REQUEST_START, 'update')

  return new Promise((resolve, reject) => {
    model
      .save()
      .then(response => {
        commit(types.UPDATE_PRODUCT_SUCCESS, response)

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
  commit(types.API_REQUEST_START, 'destroy')

  return new Promise((resolve, reject) => {
    model
      .destroy()
      .then(response => {
        commit(types.DELETE_PRODUCT_SUCCESS, id)

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
    commit(types.GET_RELATED_PRODUCTS_SUCCESS, response)

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
    commit(types.GET_PRODUCT_SUCCESS, response)

    resolve(response)
  })
}
