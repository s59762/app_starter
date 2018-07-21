import ResourceModelBase from 'odd-resource_model'
import axios from 'axios'
import FetchingDataOptionsService from 'odd-fetching_data_options_service'

const OPTIONS = {
  apiPath: '/api',
  apiVersion: 'v1',
  scope: 'web',
  resourceType: 'brands',
  attributes: [
    'id',
    'name',
    'introduce',
    'description',
    'products_count',
    'logo',
    'created_at',
    'updated_at'
  ],
  editableAttributes: [
    'name',
    'introduce',
    'description',
    'uploaded_attachment_ids'
  ]
}

export default class Brand extends ResourceModelBase {
  constructor(attributes = {}) {
    super(OPTIONS, attributes)
  }

  updateLogo(formData) {
    return axios.put(`${this.apiBasePath()}/${this.id}/logo`, formData)
  }

  fetchProducts(options) {
    return axios.get(`${this.apiBasePath()}/${this.id}/products?${FetchingDataOptionsService.call(options)}`)
  }

  fetchBanners(options) {
    return axios.get(`${this.apiBasePath()}/${this.id}/banners?${FetchingDataOptionsService.call(options)}`)
  }

  static uploadAttachments(formData) {
    return axios.post(`${new this().apiBasePath({ withResourceType: false })}/editor_attachments`, formData)
  }

  // extra methods or helpers here...

  hasLogo() {
    return this.logo && this.logo.url !== null
  }
}
