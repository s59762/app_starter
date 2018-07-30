import * as types from './mutation-types'
import Banner from '../../resource_models/banner'

export const all = ({
  dispatch,
  commit
}, options) => {
  commit(types.API_REQUEST_START, 'all')

  return new Promise((resolve, reject) => {
    Banner.all(options)
      .then(response => {
        commit(types.FETCH_BANNERS_SUCCESS, response)

        resolve(response)
      })
      .catch(errors => {
        commit(types.API_REQUEST_FAIL, errors)
        dispatch('errorMessageHandler', {
          errors,
          retryAction: all,
          ref: {
            dispatch,
            commit
          },
          params: options
        }, {
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
    Banner.find(id)
      .then(response => {
        commit(types.GET_BANNER_SUCCESS, response)

        resolve(response)
      })
      .catch(errors => {
        commit(types.API_REQUEST_FAIL, errors)
        dispatch('errorMessageHandler', {
          errors,
          retryAction: find,
          ref: {
            dispatch,
            commit
          },
          params: id
        }, {
          root: true
        })

        reject(errors)
      })
  })
}

export const save = ({
  dispatch,
  commit
}, {
  model,
  formData
}) => {
  commit(types.API_REQUEST_START, 'save')

  return new Promise((resolve, reject) => {
    model.save(formData)
      .then(response => {
        if (model.isNewRecord()) {
          commit(types.ADD_BANNER_SUCCESS, response)
        } else {
          commit(types.UPDATE_BANNER_SUCCESS, response)
        }

        resolve(response)
      })
      .catch(errors => {
        model.errors.record(errors)
        commit(types.API_REQUEST_FAIL, errors)
        dispatch('errorMessageHandler', {
          errors,
          retryAction: save,
          ref: {
            dispatch,
            commit
          },
          params: {
            model,
            formData
          }
        }, {
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
    model.destroy()
      .then(response => {
        commit(types.DELETE_BANNER_SUCCESS, model.id)

        resolve(response)
      })
      .catch(errors => {
        model.errors.record(errors)
        commit(types.API_REQUEST_FAIL, errors)
        dispatch('errorMessageHandler', {
          errors,
          retryAction: destroy,
          ref: {
            dispatch,
            commit
          },
          params: model
        }, {
          root: true
        })

        reject(errors)
      })
  })
}

export const useTypes = ({
  dispatch,
  commit
}) => {
  commit(types.API_REQUEST_START, 'useTypes')

  return new Promise((resolve, reject) => {
    Banner.useTypes()
      .then(response => {
        commit(types.FETCH_BANNER_USE_TYPES_SUCCESS, response)

        resolve(response)
      })
      .catch(errors => {
        commit(types.API_REQUEST_FAIL, errors)
        dispatch('errorMessageHandler', {
          errors,
          retryAction: useTypes,
          ref: {
            dispatch,
            commit
          },
          params: {}
        }, {
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
    commit(types.GET_RELATED_BANNERS_SUCCESS, response)

    resolve(response)
  })
}

export const getResourceFromRelationship = ({
  commit
}, response) => {
  return new Promise((resolve, reject) => {
    commit(types.GET_BANNER_SUCCESS, response)

    resolve(response)
  })
}
