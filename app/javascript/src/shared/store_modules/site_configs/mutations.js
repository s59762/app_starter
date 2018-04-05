import * as types from './mutation-types'
import MutationHelpers from '../mutation_helpers'

const helpers = new MutationHelpers('site_config')

export default {
  [types.GET_SITE_CONFIG_START](state) {
    state.isCallingAPI = true
  },

  [types.GET_SITE_CONFIG_SUCCESS](state, response) {
    helpers.storeSiteConfigs(state, response)

    state.isCallingAPI = false
  },

  [types.UPDATE_SITE_CONFIG_START](state) {
    state.isCallingAPI = true
  },

  [types.UPDATE_SITE_CONFIG_SUCCESS](state, response) {
    helpers.storeSiteConfigs(state, response)

    state.isCallingAPI = false
  },

  [types.API_REQUEST_FAIL](state, errors) {
    state.errors.record(errors)
    state.isCallingAPI = false
  }
}
