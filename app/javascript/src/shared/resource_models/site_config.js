import ModelBase from './base'
import axios from 'axios'

export default class Siteconfig extends ModelBase {
  constructor() {
    super({ resource_type: 'site_config' })
  }

  /**
   * 對 API 送出請求，拿回 site configs
   *
   * @returns {Promise} 回傳 response 或 errors
   */
  show() {
    return axios.get(`${this.api_base_path}/${this.api_version}/${this.scope}/${this.resource_type}`)
  }

  /**
   * 對 API 送出請求，更新 MetaTags 設定
   *
   * @returns {Promise} 回傳 response 或 errors
   */
  updateMetaTags(metaTags) {
    return axios.put(
      `${this.api_base_path}/${this.api_version}/${this.scope}/${this.resource_type}/meta_tags`,
      metaTags
    )
  }
}
