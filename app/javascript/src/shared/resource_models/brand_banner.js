import axios from 'axios'
import ResourceModelBase from 'odd-resource_model'

const OPTIONS = {
  apiPath: '/api',
  apiVersion: 'v1',
  scope: 'web',
  resourceType: 'brand_banners',
  attributes: ['id', 'image', 'alt_text', 'position'],
  editableAttributes: ['position']
}

export default class BrandBanner extends ResourceModelBase {
  constructor(attributes = {}) {
    super(OPTIONS, attributes)
  }

  /**
   * Banner 使用 form data 傳遞資料，因此重新定義 `#save`
   *
   * @param {FormData} formData 內容包含 `banner[image]`, `banner[alt_text]`, `banner[brand_id]`
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
