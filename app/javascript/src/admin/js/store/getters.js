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

export const deviceInfo = state => {
  return state.device
}

export const isMobile = state => {
  return state.device.isMobile && state.device.deviceType !== 'tablet'
}

export const isTablet = state => {
  return state.device.isMobile && state.device.deviceType === 'tablet'
}

export const isDesktop = state => {
  return state.device.deviceType === 'desktop'
}
