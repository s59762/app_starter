import Vue from 'vue/dist/vue.esm'
import Vuex from 'vuex'
import * as getters from './getters'
import * as actions from './actions'
import mutations from './mutations'
import admins from '../../../shared/store_modules/admins'
import users from '../../../shared/store_modules/users'
import siteConfigs from '../../../shared/store_modules/site_configs'
import CurrentUserAssignService from '../../../shared/services/current_user_assign_service'

Vue.use(Vuex)

const state = {
  currentUser: CurrentUserAssignService.call('admin'),
  flashMessages: [],
  queryString: {},
  device: {
    isMobile: false
  },
  sidebar: {
    isOpen: false
  }
}

export default new Vuex.Store({
  state,
  getters,
  actions,
  mutations,
  modules: {
    admins,
    users,
    siteConfigs
  }
})
