import * as types from './mutation-types'

export default {
  [types.SET_FLASH_MESSAGES](state, messages) {
    state.flashMessages = messages
  },

  [types.ADD_FLASH_MESSAGES](state, message) {
    state.flashMessages.push(message)
  },

  [types.CLEAR_FLASH_MESSAGES](state) {
    state.flashMessages = []
  },

  [types.TOGGLE_SIDEBAR](state, option) {
    if (state.device.isMobile) {
      state.sidebar.isOpen = option
    } else {
      state.sidebar.isOpen = true
    }
  },

  [types.TOGGLE_DEVICE](state, device) {
    state.device.isMobile = device === 'mobile'
  }
}
