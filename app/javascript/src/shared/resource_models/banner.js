import axios from 'axios'
import ResourceModelBase from 'odd-resource_model'

const OPTIONS = {
  apiPath: '/api',
  apiVersion: 'v1',
  scope: 'web',
  resourceType: 'banners',
  attributes: ['id', 'image', 'alt_text', 'use_type', 'position'],
  editableAttributes: ['position']
}

export default class Banner extends ResourceModelBase {
  constructor(attributes = {}) {
    super(OPTIONS, attributes)
  }

  static useTypes() {
    return axios.get(`${new this().apiBasePath()}/use_type`)
  }

  /**
   * Banner 使用 form data 傳遞資料，因此重新定義 `#save`
   *
   * @param {FormData} formData 內容包含 `banner[image]`, `banner[alt_text]`
   * @returns {Promise} 回傳 response 或 errors
   */
  save(formData) {
    if (this.isNewRecord()) {
      return axios.post(this.apiBasePath(), formData)
    }
    return axios.put(`${this.apiBasePath()}/${this.id}`, formData)
  }
  // extra methods or helpers here...
}
