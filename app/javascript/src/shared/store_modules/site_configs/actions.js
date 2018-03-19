import * as types from './mutation-types'
import SiteConfigModel from '../../resource_models/site_config'

const SiteConfig = new SiteConfigModel()

/**
 * 從 Server 取得所有 SiteConfig
 *
 * @param {object} options 可傳入 paginate options 或其他 filter 功能。
 *
 * @returns {promise} response or errors
 */
export const fetchConfigs = ({ dispatch, commit }) => {
  commit(types.GET_SITE_CONFIG_START)

  return new Promise((resolve, reject) => {
    SiteConfig.show()
      .then(response => {
        commit(types.GET_SITE_CONFIG_SUCCESS, response)

        resolve(response)
      })
      .catch(errors => {
        commit(types.API_REQUEST_FAIL, errors)
        dispatch('errorMessageHandler', errors, { root: true })

        reject(errors)
      })
  })
}

/**
 * 更新 MetaTags 設定
 *
 * @returns {promise} response or errors
 */
export const updateMetaTags = ({ dispatch, commit }, metaTags) => {
  commit(types.UPDATE_SITE_CONFIG_START)

  return new Promise((resolve, reject) => {
    SiteConfig.updateMetaTags(metaTags)
      .then(response => {
        commit(types.UPDATE_SITE_CONFIG_SUCCESS, response)

        resolve(response)
      })
      .catch(errors => {
        commit(types.API_REQUEST_FAIL, errors)
        dispatch('errorMessageHandler', errors, { root: true })

        reject(errors)
      })
  })
}
