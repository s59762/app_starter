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
    'product'
  ],
  editableAttributes: []
}

export default class ProductImage extends ResourceModelBase {
  constructor(attributes = {}) {
    super(OPTIONS, attributes)
  }

  // extra methods or helpers here...
}
