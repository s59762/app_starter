import * as types from './mutation-types'
import MutationHelpers from '../mutation_helpers'

const helpers = new MutationHelpers('products')

export default {
  [types.FETCH_PRODUCTS_START](state) {
    state.isCallingAPI = true
  },

  [types.FETCH_PRODUCTS_SUCCESS](state, response) {
    helpers.replaceEntities(state, response)

    state.isCallingAPI = false
  },

  [types.GET_RELATED_PRODUCTS_SUCCESS](state, response) {
    helpers.storeResourcesToEntities(state, response)

    state.isCallingAPI = false
  },

  [types.GET_PRODUCT_START](state) {
    state.isCallingAPI = true
  },

  [types.GET_PRODUCT_SUCCESS](state, response) {
    helpers.storeOneResourceToEntities(state, response)

    state.isCallingAPI = false
  },

  [types.ADD_PRODUCT_START](state) {
    state.isCallingAPI = true
  },

  [types.ADD_PRODUCT_SUCCESS](state, response) {
    helpers.storeOneResourceToEntities(state, response)
    helpers.pushResourceToResult(state, response)

    state.isCallingAPI = false
  },

  [types.UPDATE_PRODUCT_START](state) {
    state.isCallingAPI = true
  },

  [types.UPDATE_PRODUCT_SUCCESS](state, response) {
    helpers.storeOneResourceToEntities(state, response)

    state.isCallingAPI = false
  },

  [types.DELETE_PRODUCT_START](state) {
    state.isCallingAPI = true
  },

  [types.DELETE_PRODUCT_SUCCESS](state, id) {
    helpers.removeOneResourceFromEntities(state, id)

    state.isCallingAPI = false
  },

  [types.PRODUCT_IMAGE_UPLOAD_START](state) {
    state.isCallingAPI = true
  },

  [types.PRODUCT_IMAGE_UPLOAD_SUCCESS](state, response) {
    state.isCallingAPI = false
  },

  [types.API_REQUEST_FAIL](state, errors) {
    state.errors.record(errors)
    state.isCallingAPI = false
  }
}
