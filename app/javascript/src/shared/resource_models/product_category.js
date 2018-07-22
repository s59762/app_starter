import axios from 'axios'
import ResourceModelBase from 'odd-resource_model'
import FetchingDataOptionsService from 'odd-fetching_data_options_service'

const OPTIONS = {
  apiPath: '/api',
  apiVersion: 'v1',
  scope: 'web',
  resourceType: 'product_categories',
  attributes: [
    'id',
    'name',
    'description',
    'parent',
    'parent_id',
    'sub_categories',
    'products',
    'products_count',
    'created_at',
    'updated_at'
  ],
  editableAttributes: ['name', 'description', 'parent_id']
}

export default class ProductCategory extends ResourceModelBase {
  constructor(attributes = {}) {
    super(OPTIONS, attributes)
  }

  fetchProducts(options = {}) {
    return axios.get(`${this.apiBasePath()}/${this.id}/products?${FetchingDataOptionsService.call(options)}`)
  }
  // extra methods or helpers here...
}
