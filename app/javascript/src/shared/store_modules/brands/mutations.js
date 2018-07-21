import * as types from './mutation-types'
import MutationHelpers from '../mutation_helpers'

const helpers = new MutationHelpers('brands')

export default {
  [types.FETCH_BRANDS_SUCCESS](state, response) {
    helpers.replaceEntities(state, response)

    state.isCallingAPI = false
  },

  [types.GET_RELATED_BRANDS_SUCCESS](state, response) {
    helpers.storeResourcesToEntities(state, response)

    state.isCallingAPI = false
  },

  [types.GET_BRAND_SUCCESS](state, response) {
    helpers.storeOneResourceToEntities(state, response)

    state.isCallingAPI = false
  },

  [types.ADD_BRAND_SUCCESS](state, response) {
    helpers.storeOneResourceToEntities(state, response)
    helpers.pushResourceToResult(state, response)

    state.isCallingAPI = false
  },

  [types.UPDATE_BRAND_SUCCESS](state, response) {
    helpers.storeOneResourceToEntities(state, response)

    state.isCallingAPI = false
  },

  [types.DELETE_BRAND_SUCCESS](state, id) {
    helpers.removeOneResourceFromEntities(state, id)

    state.isCallingAPI = false
  },

  [types.FETCH_BRAND_PRODUCTS_SUCCESS](state) {
    state.isCallingAPI = false
  },

  [types.FETCH_BRAND_BANNERS_SUCCESS](state) {
    state.isCallingAPI = false
  },

  [types.UPLOAD_ATTACHMENTS_SUCCESS](state) {
    state.isCallingAPI = false
  },

  [types.API_REQUEST_START](state, action = 'not provided') {
    state.isCallingAPI = true
  },

  [types.API_REQUEST_FAIL](state, errors) {
    state.errors.record(errors)
    state.isCallingAPI = false
  }
}
