import * as types from './mutation-types'
import AdminModel from '../../resource_models/admin'

const Admin = new AdminModel()

export default {
  [types.FETCH_ADMIN_ROLES_START](state) {
    state.isCallingAPI = true
  },

  [types.FETCH_ADMIN_ROLES_SUCCESS](state, response) {
    Admin.receiveAvaliableRoles(state, response)

    state.isCallingAPI = false
  },

  [types.FETCH_ADMINS_START](state) {
    state.isCallingAPI = true
  },

  [types.FETCH_ADMINS_SUCCESS](state, response) {
    Admin.replaceEntities(state, response)

    state.meta = response.data.meta
    state.isCallingAPI = false
  },

  [types.GET_RELATED_ADMINS_SUCCESS](state, response) {
    Admin.storeResourcesToEntities(state, response)

    state.isCallingAPI = false
  },

  [types.GET_ADMIN_START](state) {
    state.isCallingAPI = true
  },

  [types.GET_ADMIN_SUCCESS](state, response) {
    Admin.storeOneResourceToEntities(state, response)

    state.meta = response.data.meta
    state.isCallingAPI = false
  },

  [types.ADD_ADMIN_START](state) {
    state.isCallingAPI = true
  },

  [types.ADD_ADMIN_SUCCESS](state, response) {
    Admin.storeOneResourceToEntities(state, response)
    Admin.pushResourceToResult(state, response)

    state.meta = response.data.meta
    state.isCallingAPI = false
  },

  [types.UPDATE_ADMIN_START](state) {
    state.isCallingAPI = true
  },

  [types.UPDATE_ADMIN_SUCCESS](state, response) {
    Admin.storeOneResourceToEntities(state, response)

    state.meta = response.data.meta
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
    state.isCallingAPI = false
  }
}
