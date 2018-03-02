import * as types from './mutation-types'
import AdminModel from '../../resource_models/admin'

const Admin = new AdminModel()

/**
 * 從 Server 取得所有 Resource
 *
 * @returns {promise} response or errors
 */
export const fetchAllResources = ({ dispatch, commit }, options) => {
  commit(types.FETCH_ADMINS_START)

  return new Promise((resolve, reject) => {
    Admin.index(options)
      .then(response => {
        commit(types.FETCH_ADMINS_SUCCESS, response)

        resolve(response)
      })
      .catch(errors => {
        commit(types.API_REQUEST_FAIL, errors)

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
  commit(types.GET_ADMIN_START)

  return new Promise((resolve, reject) => {
    Admin.show(id)
      .then(response => {
        commit(types.GET_ADMIN_SUCCESS, response)

        resolve(response)
      })
      .catch(errors => {
        commit(types.API_REQUEST_FAIL, errors)

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
  commit(types.ADD_ADMIN_START)

  return new Promise((resolve, reject) => {
    Admin.create(resource)
      .then(response => {
        commit(types.ADD_ADMIN_SUCCESS, response)

        resolve(response)
      })
      .catch(errors => {
        commit(types.API_REQUEST_FAIL, errors)

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
  commit(types.UPDATE_ADMIN_START)

  return new Promise((resolve, reject) => {
    Admin.update(id, resource)
      .then(response => {
        commit(types.UPDATE_ADMIN_SUCCESS, response)

        resolve(response)
      })
      .catch(errors => {
        commit(types.API_REQUEST_FAIL, errors)

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
  commit(types.DELETE_ADMIN_START)

  return new Promise((resolve, reject) => {
    Admin.destroy(id)
      .then(response => {
        commit(types.DELETE_ADMIN_SUCCESS, id)

        resolve(response)
      })
      .catch(errors => {
        commit(types.API_REQUEST_FAIL, errors)

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
    commit(types.FETCH_ADMINS_SUCCESS, response)

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
    commit(types.GET_ADMIN_SUCCESS, response)

    resolve(response)
  })
}
