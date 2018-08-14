import ResourceModelBase from 'odd-resource_model'

const OPTIONS = {
  apiPath: '/api',
  apiVersion: 'v1',
  scope: 'web',
  resourceType: 'product_option_values',
  attributes: ['id', 'value', 'option_type_id'],
  editableAttributes: ['value', 'option_type_id']
}

export default class ProductOptionValue extends ResourceModelBase {
  constructor(attributes = {}) {
    super(OPTIONS, attributes)
  }

  // extra methods or helpers here...
}
