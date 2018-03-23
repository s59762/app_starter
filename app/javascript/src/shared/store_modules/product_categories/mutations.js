import * as types from './mutation-types'
import ProductCategoryModel from '../../resource_models/product_category'

const ProductCategory = new ProductCategoryModel()

export default {
  [types.FETCH_PRODUCT_CATEGORIES_START](state) {
    state.isCallingAPI = true
  },

  [types.FETCH_PRODUCT_CATEGORIES_SUCCESS](state, response) {
    ProductCategory.replaceEntities(state, response)

    state.isCallingAPI = false
  },

  [types.GET_RELATED_PRODUCT_CATEGORIES_SUCCESS](state, response) {
    ProductCategory.storeResourcesToEntities(state, response)

    state.isCallingAPI = false
  },

  [types.GET_PRODUCT_CATEGORY_START](state) {
    state.isCallingAPI = true
  },

  [types.GET_PRODUCT_CATEGORY_SUCCESS](state, response) {
    ProductCategory.storeOneResourceToEntities(state, response)

    state.isCallingAPI = false
  },

  [types.ADD_PRODUCT_CATEGORY_START](state) {
    state.isCallingAPI = true
  },

  [types.ADD_PRODUCT_CATEGORY_SUCCESS](state, response) {
    ProductCategory.storeOneResourceToEntities(state, response)
    ProductCategory.pushResourceToResult(state, response)

    state.isCallingAPI = false
  },

  [types.UPDATE_PRODUCT_CATEGORY_START](state) {
    state.isCallingAPI = true
  },

  [types.UPDATE_PRODUCT_CATEGORY_SUCCESS](state, response) {
    ProductCategory.storeOneResourceToEntities(state, response)

    state.isCallingAPI = false
  },

  [types.DELETE_PRODUCT_CATEGORY_START](state) {
    state.isCallingAPI = true
  },

  [types.DELETE_PRODUCT_CATEGORY_SUCCESS](state, id) {
    ProductCategory.removeOneResourceFromEntities(state, id)

    state.isCallingAPI = false
  },

  [types.API_REQUEST_FAIL](state, errors) {
    state.errors.record(errors)
    state.isCallingAPI = false
  }
}
