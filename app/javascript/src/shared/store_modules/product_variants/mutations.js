import * as types from './mutation-types'
import MutationHelpers from '../mutation_helpers'

const helpers = new MutationHelpers('product_variants')

export default {
  [types.FETCH_PRODUCT_VARIANTS_SUCCESS](state, response) {
    helpers.replaceEntities(state, response)

    state.isCallingAPI = false
  },

  [types.GET_RELATED_PRODUCT_VARIANTS_SUCCESS](state, response) {
    helpers.storeResourcesToEntities(state, response)

    state.isCallingAPI = false
  },

  [types.GET_PRODUCT_VARIANT_SUCCESS](state, response) {
    helpers.storeOneResourceToEntities(state, response)

    state.isCallingAPI = false
  },

  [types.ADD_PRODUCT_VARIANT_SUCCESS](state, response) {
    helpers.storeOneResourceToEntities(state, response)
    helpers.pushResourceToResult(state, response)

    state.isCallingAPI = false
  },

  [types.UPDATE_PRODUCT_VARIANT_SUCCESS](state, response) {
    helpers.storeOneResourceToEntities(state, response)

    state.isCallingAPI = false
  },

  [types.DELETE_PRODUCT_VARIANT_SUCCESS](state, id) {
    helpers.removeOneResourceFromEntities(state, id)

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
