import * as types from './mutation-types'
import MutationHelpers from '../mutation_helpers'

const helpers = new MutationHelpers('users')

export default {
  [types.FETCH_USERS_START](state) {
    state.isCallingAPI = true
  },

  [types.FETCH_USERS_SUCCESS](state, response) {
    helpers.replaceEntities(state, response)

    state.meta = response.data.meta
    state.isCallingAPI = false
  },

  [types.GET_RELATED_USERS_SUCCESS](state, response) {
    helpers.storeResourcesToEntities(state, response)

    state.isCallingAPI = false
  },

  [types.GET_USER_START](state) {
    state.isCallingAPI = true
  },

  [types.GET_USER_SUCCESS](state, response) {
    helpers.storeOneResourceToEntities(state, response)

    state.meta = response.data.meta
    state.isCallingAPI = false
  },

  [types.ADD_USER_START](state) {
    state.isCallingAPI = true
  },

  [types.ADD_USER_SUCCESS](state, response) {
    helpers.storeOneResourceToEntities(state, response)
    helpers.pushResourceToResult(state, response)

    state.isCallingAPI = false
  },

  [types.UPDATE_USER_START](state) {
    state.isCallingAPI = true
  },

  [types.UPDATE_USER_SUCCESS](state, response) {
    helpers.storeOneResourceToEntities(state, response)

    state.isCallingAPI = false
  },

  [types.DELETE_USER_START](state) {
    state.isCallingAPI = true
  },

  [types.DELETE_USER_SUCCESS](state, id) {
    helpers.removeOneResourceFromEntities(state, id)

    state.isCallingAPI = false
  },

  [types.API_REQUEST_FAIL](state, errors) {
    state.errors.record(errors)
    state.isCallingAPI = false
  }
}
