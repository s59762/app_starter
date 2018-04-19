import * as types from './mutation-types'
import MutationHelpers from '../mutation_helpers'

const helpers = new MutationHelpers('site_config')

export default {
  [types.GET_SITE_CONFIG_SUCCESS](state, response) {
    helpers.storeSiteConfigs(state, response)

    state.isCallingAPI = false
  },

  [types.UPDATE_SITE_CONFIG_SUCCESS](state, response) {
    helpers.storeSiteConfigs(state, response)

    state.isCallingAPI = false
  },

  [types.API_REQUEST_START](state, type = 'not provided') {
    state.isCallingAPI = true
  },

  [types.API_REQUEST_FAIL](state, errors) {
    state.errors.record(errors)
    state.isCallingAPI = false
  }
}
