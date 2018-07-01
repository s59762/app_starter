import ResourceModelBase from 'odd-resource_model'

const OPTIONS = {
  apiPath: '/api',
  apiVersion: 'v1',
  scope: 'web',
  resourceType: 'product_option_types',
  attributes: ['id', 'name', 'product_id', 'option_values'],
  editableAttributes: [
    'name'
  ]
}

export default class ProductOptionType extends ResourceModelBase {
  constructor(attributes = {}) {
    super(OPTIONS, attributes)
  }

  // extra methods or helpers here...
}
