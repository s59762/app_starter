import ResourceModelBase from 'odd-resource_model'
import axios from 'axios'

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
    'description'
  ]
}

export default class Brand extends ResourceModelBase {
  constructor(attributes = {}) {
    super(OPTIONS, attributes)
  }

  updateLogo(formData) {
    return axios.put(`${this.apiBasePath()}/${this.id}/logo`, formData)
  }

  // extra methods or helpers here...

  hasLogo() {
    return this.logo && this.logo.url !== null
  }
}
