import * as types from './mutation-types'
import Admin from '../../resource_models/admin'

export const fetchAvailableRoles = ({
  dispatch,
  commit
}) => {
  commit(types.API_REQUEST_START, 'fetchAvailableRoles')

  return new Promise((resolve, reject) => {
    Admin.roles()
      .then(response => {
        commit(types.FETCH_ADMIN_ROLES_SUCCESS, response)

        resolve(response)
      })
      .catch(errors => {
        commit(types.API_REQUEST_FAIL, errors)
        dispatch('errorMessageHandler', errors, {
          root: true
        })

        reject(errors)
      })
  })
}

export const all = ({
  dispatch,
  commit
}, options) => {
  commit(types.API_REQUEST_START, 'all')

  return new Promise((resolve, reject) => {
    Admin.all(options)
      .then(response => {
        commit(types.FETCH_ADMINS_SUCCESS, response)

        resolve(response)
      })
      .catch(errors => {
        commit(types.API_REQUEST_FAIL, errors)
        dispatch('errorMessageHandler', errors, {
          root: true
        })

        reject(errors)
      })
  })
}

export const find = ({
  dispatch,
  commit
}, id) => {
  commit(types.API_REQUEST_START, 'find')

  return new Promise((resolve, reject) => {
    Admin.find(id)
      .then(response => {
        commit(types.GET_ADMIN_SUCCESS, response)

        resolve(response)
      })
      .catch(errors => {
        commit(types.API_REQUEST_FAIL, errors)
        dispatch('errorMessageHandler', errors, {
          root: true
        })

        reject(errors)
      })
  })
}

export const save = ({
  dispatch,
  commit
}, model) => {
  commit(types.API_REQUEST_START, 'save')

  return new Promise((resolve, reject) => {
    model
      .save()
      .then(response => {
        if (model.isNewRecord()) {
          commit(types.ADD_ADMIN_SUCCESS, response)
        } else {
          commit(types.UPDATE_ADMIN_SUCCESS, response)
        }

        resolve(response)
      })
      .catch(errors => {
        model.errors.record(errors)
        commit(types.API_REQUEST_FAIL, errors)
        dispatch('errorMessageHandler', errors, {
          root: true
        })

        reject(errors)
      })
  })
}

export const destroy = ({
  dispatch,
  commit
}, model) => {
  commit(types.API_REQUEST_START, 'destroy')

  return new Promise((resolve, reject) => {
    model
      .destroy()
      .then(response => {
        commit(types.DELETE_ADMIN_SUCCESS, model.id)

        resolve(response)
      })
      .catch(errors => {
        model.errors.record(errors)
        commit(types.API_REQUEST_FAIL, errors)
        dispatch('errorMessageHandler', errors, {
          root: true
        })

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
export const suspend = ({
  dispatch,
  commit
}, model) => {
  commit(types.API_REQUEST_START, 'suspend')

  return new Promise((resolve, reject) => {
    model
      .suspend()
      .then(response => {
        commit(types.UPDATE_ADMIN_SUCCESS, response)

        resolve(response)
      })
      .catch(errors => {
        model.errors.record(errors)
        commit(types.API_REQUEST_FAIL, errors)
        dispatch('errorMessageHandler', errors, {
          root: true
        })

        reject(errors)
      })
  })
}

export const receiveResourcesFromRelationships = ({
  commit
}, response) => {
  return new Promise((resolve, reject) => {
    commit(types.GET_RELATED_ADMINS_SUCCESS, response)

    resolve(response)
  })
}

export const getResourceFromRelationship = ({
  commit
}, response) => {
  return new Promise((resolve, reject) => {
    commit(types.GET_ADMIN_SUCCESS, response)

    resolve(response)
  })
}
