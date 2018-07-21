import * as types from './mutation-types'
import MutationHelpers from '../mutation_helpers'

const helpers = new MutationHelpers('banners')

export default {
  [types.FETCH_BANNERS_SUCCESS](state, response) {
    helpers.replaceEntities(state, response)

    state.isCallingAPI = false
  },

  [types.GET_RELATED_BANNERS_SUCCESS](state, response) {
    helpers.storeResourcesToEntities(state, response)

    state.isCallingAPI = false
  },

  [types.GET_BANNER_SUCCESS](state, response) {
    helpers.storeOneResourceToEntities(state, response)

    state.isCallingAPI = false
  },

  [types.ADD_BANNER_SUCCESS](state, response) {
    helpers.storeOneResourceToEntities(state, response)
    helpers.pushResourceToResult(state, response)

    state.isCallingAPI = false
  },

  [types.UPDATE_BANNER_SUCCESS](state, response) {
    helpers.storeOneResourceToEntities(state, response)

    state.isCallingAPI = false
  },

  [types.DELETE_BANNER_SUCCESS](state, id) {
    helpers.removeOneResourceFromEntities(state, id)

    state.isCallingAPI = false
  },

  [types.FETCH_BANNER_USE_TYPES_SUCCESS](state, response) {
    state.useTypes = response.data.data

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
