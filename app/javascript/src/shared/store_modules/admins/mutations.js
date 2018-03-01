import * as types from './mutation-types'
import AdminModel from '../../resource_models/admin'

const Admin = new AdminModel()

export default {
  [types.FETCH_ADMINS_START](state) {
    state.isFetchingResources = true
  },

  [types.FETCH_ADMINS_SUCCESS](state, response) {
    Admin.storeResourcesToEntities(state, response)

    state.isCallingAPI = false
  },

  [types.GET_ADMIN_START](state) {
    state.isCallingAPI = true
  },

  [types.GET_ADMIN_SUCCESS](state, response) {
    Admin.storeOneResourceToEntities(state, response)

    state.isCallingAPI = false
  },

  [types.ADD_ADMIN_START](state) {
    state.isCallingAPI = true
  },

  [types.ADD_ADMIN_SUCCESS](state, response) {
    Admin.storeOneResourceToEntities(state, response)
    Admin.pushResourceToResult(state, response)

    state.isCallingAPI = false
  },

  [types.UPDATE_ADMIN_START](state) {
    state.isCallingAPI = true
  },

  [types.UPDATE_ADMIN_SUCCESS](state, response) {
    Admin.storeOneResourceToEntities(state, response)

    state.isCallingAPI = false
  },

  [types.DELETE_ADMIN_START](state) {
    state.isCallingAPI = true
  },

  [types.DELETE_ADMIN_SUCCESS](state, id) {
    Admin.removeOneResourceFromEntities(state, id)

    state.isCallingAPI = false
  },

  [types.API_REQUEST_FAIL](state, errors) {
    state.errors.record(errors.response.data)
    state.isFetchingResources = false
  }
}
