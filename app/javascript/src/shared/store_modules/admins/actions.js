import * as types from './mutation-types'
import Admin from '../../resource_models/admin'

// const Admin = new AdminModel()

/**
 * 從 Server 取得所有 Admin 可用的 roles 選項
 *
 * @returns {promise} response or errors
 */
export const fetchAvailableRoles = ({ dispatch, commit }) => {
  commit(types.FETCH_ADMIN_ROLES_START)

  return new Promise((resolve, reject) => {
    Admin.roles()
      .then(response => {
        commit(types.FETCH_ADMIN_ROLES_SUCCESS, response)

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
 * 從 Server 取得所有 Resource
 *
 * @returns {promise} response or errors
 */
export const all = ({ dispatch, commit }, options) => {
  commit(types.FETCH_ADMINS_START)

  return new Promise((resolve, reject) => {
    Admin.all(options)
      .then(response => {
        commit(types.FETCH_ADMINS_SUCCESS, response)

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
  commit(types.GET_ADMIN_START)

  return new Promise((resolve, reject) => {
    Admin.find(id)
      .then(response => {
        commit(types.GET_ADMIN_SUCCESS, response)

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
 * @param {Object} resource JSON:API 規格的 request body
 * @returns {promise} response or errors
 */
export const create = ({ dispatch, commit }, model) => {
  commit(types.ADD_ADMIN_START)

  return new Promise((resolve, reject) => {
    model
      .save()
      .then(response => {
        commit(types.ADD_ADMIN_SUCCESS, response)

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
 * @param {Object} resource JSON:API 規格的 request body
 * @returns {promise} response or errors
 */
export const update = ({ dispatch, commit }, model) => {
  commit(types.UPDATE_ADMIN_START)

  return new Promise((resolve, reject) => {
    model
      .save()
      .then(response => {
        commit(types.UPDATE_ADMIN_SUCCESS, response)

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
  commit(types.DELETE_ADMIN_START)

  return new Promise((resolve, reject) => {
    model
      .destroy()
      .then(response => {
        commit(types.DELETE_ADMIN_SUCCESS, model.id)

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
 * toggle Admin `is_suspended` 的狀態
 *
 * @param {number} id 指定的 resource ID
 * @returns {promise} response or errors
 */
export const suspend = ({ dispatch, commit }, model) => {
  commit(types.UPDATE_ADMIN_START)

  return new Promise((resolve, reject) => {
    model
      .suspend()
      .then(response => {
        commit(types.UPDATE_ADMIN_SUCCESS, response)

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
 * @param {Object} response axios response object
 * @returns {promise} response or errors
 */
export const receiveResourcesFromRelationships = ({ commit }, response) => {
  return new Promise((resolve, reject) => {
    commit(types.GET_RELATED_ADMINS_SUCCESS, response)

    resolve(response)
  })
}

/**
 * 收到單筆其他 resource 的 relationship
 *
 * @param {Object} response axios response object
 * @returns {promise} response or errors
 */
export const getResourceFromRelationship = ({ commit }, response) => {
  return new Promise((resolve, reject) => {
    commit(types.GET_ADMIN_SUCCESS, response)

    resolve(response)
  })
}
