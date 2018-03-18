import ModelBase from './base'
import axios from 'axios'

export default class Siteconfig extends ModelBase {
  constructor() {
    super({ resource_type: 'siteConfigs' })
  }

  /**
   * 對 API 送出請求，拿回 site configs
   *
   * @returns {Promise} 回傳 response 或 errors
   */
  show() {
    return axios.get(`${this.api_base_path}/${this.api_version}/${this.scope}/site_config`)
  }

  storeConfigs(state, response) {
    const result = response.data

    state.configs = result
  }
}
