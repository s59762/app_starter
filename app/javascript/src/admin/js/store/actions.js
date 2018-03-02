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
  const siteMainContainer = document.querySelector('.site-main-container')

  if (option) {
    siteMainContainer.classList.add('sidebar-is-opened')
  } else {
    siteMainContainer.classList.remove('sidebar-is-opened')
  }
  commit(types.TOGGLE_SIDEBAR, option)
}

export const updateQueryString = ({ commit }, { stateObj, newQueryString }) => {
  let title = document.title

  window.history.pushState(stateObj, title, newQueryString)
  commit(types.UPDATE_QUERY_STRING)
}

export const updateQueryStringFromURL = ({ commit }) => {
  commit(types.UPDATE_QUERY_STRING)
}

export const toggleDevice = ({ commit }, device) => {
  commit(types.TOGGLE_DEVICE, device)
}
