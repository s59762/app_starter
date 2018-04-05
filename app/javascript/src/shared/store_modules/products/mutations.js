import * as types from './mutation-types'
import ProductModel from '../../resource_models/product'

const Product = new ProductModel()

export default {
  [types.FETCH_PRODUCTS_START](state) {
    state.isCallingAPI = true
  },

  [types.FETCH_PRODUCTS_SUCCESS](state, response) {
    Product.replaceEntities(state, response)

    state.isCallingAPI = false
  },

  [types.GET_RELATED_PRODUCTS_SUCCESS](state, response) {
    Product.storeResourcesToEntities(state, response)

    state.isCallingAPI = false
  },

  [types.GET_PRODUCT_START](state) {
    state.isCallingAPI = true
  },

  [types.GET_PRODUCT_SUCCESS](state, response) {
    Product.storeOneResourceToEntities(state, response)

    state.isCallingAPI = false
  },

  [types.ADD_PRODUCT_START](state) {
    state.isCallingAPI = true
  },

  [types.ADD_PRODUCT_SUCCESS](state, response) {
    Product.storeOneResourceToEntities(state, response)
    Product.pushResourceToResult(state, response)

    state.isCallingAPI = false
  },

  [types.UPDATE_PRODUCT_START](state) {
    state.isCallingAPI = true
  },

  [types.UPDATE_PRODUCT_SUCCESS](state, response) {
    Product.storeOneResourceToEntities(state, response)

    state.isCallingAPI = false
  },

  [types.DELETE_PRODUCT_START](state) {
    state.isCallingAPI = true
  },

  [types.DELETE_PRODUCT_SUCCESS](state, id) {
    Product.removeOneResourceFromEntities(state, id)

    state.isCallingAPI = false
  },

  [types.API_REQUEST_FAIL](state, errors) {
    state.errors.record(errors)
    state.isCallingAPI = false
  }
}
