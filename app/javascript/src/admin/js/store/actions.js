import * as types from './mutation-types'

export const setFlashMessages = ({ commit }, messages) => {
  commit(types.SET_FLASH_MESSAGES, messages)
}

export const addFlashMessage = ({ commit }, message) => {
  commit(types.ADD_FLASH_MESSAGES, message)
}

export const clearFlashMessages = ({ commit }) => {
  commit(types.CLEAR_FLASH_MESSAGES)
}

export const toggleSidebar = ({ commit }, option) => {
  commit(types.TOGGLE_SIDEBAR, option)
}

export const toggleDevice = ({ commit }, device) => {
  commit(types.TOGGLE_DEVICE, device)
}
