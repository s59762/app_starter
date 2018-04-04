import * as types from './mutation-types'
import UserModel from '../../resource_models/user'

const User = new UserModel()

/**
 * 從 Server 取得所有 Resource
 *
 * @param {object} options 可傳入 paginate options 或其他 filter 功能。
 *
 * @returns {promise} response or errors
 */
export const allResources = ({ dispatch, commit }, options) => {
  commit(types.FETCH_USERS_START)

  return new Promise((resolve, reject) => {
    User.index(options)
      .then(response => {
        commit(types.FETCH_USERS_SUCCESS, response)

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
export const getResource = ({ dispatch, commit }, id) => {
  commit(types.GET_USER_START)

  return new Promise((resolve, reject) => {
    User.show(id)
      .then(response => {
        commit(types.GET_USER_SUCCESS, response)

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
export const addResource = ({ dispatch, commit }, resource) => {
  commit(types.ADD_USER_START)

  return new Promise((resolve, reject) => {
    User.create(resource)
      .then(response => {
        commit(types.ADD_USER_SUCCESS, response)

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
export const updateResource = ({ dispatch, commit }, { id, resource }) => {
  commit(types.UPDATE_USER_START)

  return new Promise((resolve, reject) => {
    User.update(id, resource)
      .then(response => {
        commit(types.UPDATE_USER_SUCCESS, response)

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
export const deleteResource = ({ dispatch, commit }, id) => {
  commit(types.DELETE_USER_START)

  return new Promise((resolve, reject) => {
    User.destroy(id)
      .then(response => {
        commit(types.DELETE_USER_SUCCESS, id)

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
    commit(types.GET_RELATED_USERS_SUCCESS, response)

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
    commit(types.GET_USER_SUCCESS, response)

    resolve(response)
  })
}
