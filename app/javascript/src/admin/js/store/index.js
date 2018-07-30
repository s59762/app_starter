import Vue from 'vue/dist/vue.esm'
import Vuex from 'vuex'
import * as getters from './getters'
import * as actions from './actions'
import mutations from './mutations'
import admins from '../../../shared/store_modules/admins'
import users from '../../../shared/store_modules/users'
import brands from '../../../shared/store_modules/brands'
import brandBanners from '../../../shared/store_modules/brand_banners'
import productCategories from '../../../shared/store_modules/product_categories'
import products from '../../../shared/store_modules/products'
import productOptionTypes from '../../../shared/store_modules/product_option_types'
import productOptionValues from '../../../shared/store_modules/product_option_values'
import productVariants from '../../../shared/store_modules/product_variants'
import productImages from '../../../shared/store_modules/product_images'
import banners from '../../../shared/store_modules/banners'
import siteConfigs from '../../../shared/store_modules/site_configs'
import CurrentUserAssignService from '../../../shared/services/current_user_assign_service'

Vue.use(Vuex)

const state = {
  currentUser: CurrentUserAssignService.call('admin'),
  flashMessages: [],
  queryString: {},
  retryCounter: 0,
  device: {
    isMobile: false,
    deviceType: ''
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
    brands,
    brandBanners,
    productCategories,
    products,
    productOptionTypes,
    productOptionValues,
    productVariants,
    productImages,
    banners,
    siteConfigs
  }
})
