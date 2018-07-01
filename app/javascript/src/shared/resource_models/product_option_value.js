import ResourceModelBase from 'odd-resource_model'

const OPTIONS = {
  apiPath: '/api',
  apiVersion: 'v1',
  scope: 'web',
  resourceType: 'product_option_values',
  attributes: ['id', 'value'],
  editableAttributes: ['value']
}

export default class ProductOptionValue extends ResourceModelBase {
  constructor(attributes = {}) {
    super(OPTIONS, attributes)
  }

  // extra methods or helpers here...
}
