import SiteConfig from '../../resource_models/site_config'

/**
 * @returns {boolean} 這個 module 是否正在與 API 溝通中
 */
export const isLoading = state => {
  return state.isCallingAPI
}

/**
 * 依照 server 回傳的排序列出所有 Resource
 * 若沒有 Resource 則不回傳
 *
 * @returns {array} 所有 Resource
 */
export const allConfigs = state => {
  return new SiteConfig(state.configs)
}

/**
 * 回傳 API response 中的 meta 資訊
 *
 * @returns {object} meta info from API response
 */
export const metaInfo = state => {
  return state.meta
}

/**
 * 回傳 state 中的 errors
 *
 * @returns {object} Errors 物件
 */
export const errors = state => {
  return state.errors
}
