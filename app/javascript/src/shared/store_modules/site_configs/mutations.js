import * as types from './mutation-types'
import SiteConfigModel from '../../resource_models/site_config'

const SiteConfig = new SiteConfigModel()

export default {
  [types.GET_SITE_CONFIG_START](state) {
    state.isCallingAPI = true
  },

  [types.GET_SITE_CONFIG_SUCCESS](state, response) {
    SiteConfig.storeConfigs(state, response)

    state.isCallingAPI = false
  },

  [types.UPDATE_SITE_CONFIG_START](state) {
    state.isCallingAPI = true
  },

  [types.UPDATE_SITE_CONFIG_SUCCESS](state, response) {
    SiteConfig.storeConfigs(state, response)

    state.isCallingAPI = false
  },

  [types.API_REQUEST_FAIL](state, errors) {
    state.errors.record(errors)
    state.isCallingAPI = false
  }
}
