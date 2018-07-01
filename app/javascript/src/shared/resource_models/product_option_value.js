import ResourceModelBase from 'odd-resource_model'

const OPTIONS = {
  apiPath: '/api',
  apiVersion: 'v1',
  scope: 'web',
  resourceType: 'product_option_values',
  attributes: ['id', 'created_at', 'updated_at'],
  editableAttributes: []
}

export default class ProductOptionValue extends ResourceModelBase {
  constructor(attributes = {}) {
    super(OPTIONS, attributes)
  }

  // extra methods or helpers here...
}
