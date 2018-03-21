export const flashMessages = state => {
  return state.flashMessages
}

/**
 * get currentUser state
 *
 * @returns {Object} current user object
 */
export const currentUser = state => {
  return state.currentUser
}

export const queryString = state => {
  return state.queryString
}

export const sidebarIsOpen = state => {
  return state.sidebar.isOpen
}

export const deviceIsMobile = state => {
  return state.device.isMobile
}
