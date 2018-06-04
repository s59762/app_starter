import * as types from './mutation-types'
import SiteConfig from '../../resource_models/site_config'

export const fetchConfigs = ({
  dispatch,
  commit
}) => {
  commit(types.API_REQUEST_START, 'fetchConfigs')

  return new Promise((resolve, reject) => {
    SiteConfig.all()
      .then(response => {
        commit(types.GET_SITE_CONFIG_SUCCESS, response)

        resolve(response)
      })
      .catch(errors => {
        commit(types.API_REQUEST_FAIL, errors)
        dispatch('errorMessageHandler', errors, {
          root: true
        })

        reject(errors)
      })
  })
}

export const updateMetaTags = ({
  dispatch,
  commit
}, model) => {
  commit(types.API_REQUEST_START, 'updateMetaTags')

  return new Promise((resolve, reject) => {
    model
      .updateMetaTags()
      .then(response => {
        commit(types.UPDATE_SITE_CONFIG_SUCCESS, response)

        resolve(response)
      })
      .catch(errors => {
        commit(types.API_REQUEST_FAIL, errors)
        dispatch('errorMessageHandler', errors, {
          root: true
        })

        reject(errors)
      })
  })
}
