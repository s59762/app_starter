import Vue from 'vue/dist/vue.esm'
import Vuex from 'vuex'
import * as getters from './getters'
import * as actions from './actions'
import mutations from './mutations'
import admins from '../../../shared/store_modules/admins'

Vue.use(Vuex)

const state = {
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
    admins
  }
})
