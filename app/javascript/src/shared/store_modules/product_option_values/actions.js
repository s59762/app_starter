import * as types from './mutation-types'
import ProductOptionValue from '../../resource_models/product_option_value'

export const all = ({ dispatch, commit }, options) => {
  commit(types.API_REQUEST_START, 'all')

  return new Promise((resolve, reject) => {
    ProductOptionValue.all(options)
      .then(response => {
        commit(types.FETCH_PRODUCT_OPTION_VALUES_SUCCESS, response)

        resolve(response)
      })
      .catch(errors => {
        commit(types.API_REQUEST_FAIL, errors)
        dispatch('errorMessageHandler', errors, { root: true })

        reject(errors)
      })
  })
}

export const find = ({ dispatch, commit }, id) => {
  commit(types.API_REQUEST_START, 'find')

  return new Promise((resolve, reject) => {
    ProductOptionValue.find(id)
      .then(response => {
        commit(types.GET_PRODUCT_OPTION_VALUE_SUCCESS, response)

        resolve(response)
      })
      .catch(errors => {
        commit(types.API_REQUEST_FAIL, errors)
        dispatch('errorMessageHandler', errors, { root: true })

        reject(errors)
      })
  })
}

export const save = ({ dispatch, commit }, model) => {
  commit(types.API_REQUEST_START, 'save')

  return new Promise((resolve, reject) => {
    model.save()
      .then(response => {
        if (model.isNewRecord()) {
          commit(types.ADD_PRODUCT_OPTION_VALUE_SUCCESS, response)
        } else {
          commit(types.UPDATE_PRODUCT_OPTION_VALUE_SUCCESS, response)
        }

        resolve(response)
      })
      .catch(errors => {
        model.errors.record(errors)
        commit(types.API_REQUEST_FAIL, errors)
        dispatch('errorMessageHandler', errors, { root: true })

        reject(errors)
      })
  })
}

export const destroy = ({ dispatch, commit }, model) => {
  commit(types.API_REQUEST_START, 'destroy')

  return new Promise((resolve, reject) => {
    model.destroy()
      .then(response => {
        commit(types.DELETE_PRODUCT_OPTION_VALUE_SUCCESS, model.id)

        resolve(response)
      })
      .catch(errors => {
        model.errors.record(errors)
        commit(types.API_REQUEST_FAIL, errors)
        dispatch('errorMessageHandler', errors, { root: true })

        reject(errors)
      })
  })
}

export const receiveResourcesFromRelationships = ({ commit }, response) => {
  return new Promise((resolve, reject) => {
    commit(types.GET_RELATED_PRODUCT_OPTION_VALUES_SUCCESS, response)

    resolve(response)
  })
}

export const getResourceFromRelationship = ({ commit }, response) => {
  return new Promise((resolve, reject) => {
    commit(types.GET_PRODUCT_OPTION_VALUE_SUCCESS, response)

    resolve(response)
  })
}
