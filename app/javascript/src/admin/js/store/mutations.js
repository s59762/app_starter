import * as types from './mutation-types'

export const SET_FLASH_MESSAGES = function (state, messages) {
  state.flashMessages = messages
}

export const ADD_FLASH_MESSAGES = function (state, message) {
  state.flashMessages.push(message)
}

export const CLEAR_FLASH_MESSAGES = function (state) {
  state.flashMessages = []
}
