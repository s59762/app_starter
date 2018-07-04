import axios from 'axios'
import ResourceModelBase from 'odd-resource_model'

const OPTIONS = {
  apiPath: '/api',
  apiVersion: 'v1',
  scope: 'web',
  resourceType: 'product_images',
  attributes: [
    'id',
    'use_case',
    'url',
    'thumb_url',
    'original_filename',
    'product',
    'is_cover',
    'variant_id'
  ],
  editableAttributes: []
}

export default class ProductImage extends ResourceModelBase {
  constructor(attributes = {}) {
    super(OPTIONS, attributes)
  }

  setAsCover() {
    return axios.put(`${this.apiBasePath()}/${this.id}/set_as_cover`)
  }
  // extra methods or helpers here...
}
