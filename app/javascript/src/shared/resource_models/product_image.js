import axios from 'axios'
import ResourceModelBase from 'odd-resource_model'

const OPTIONS = {
  apiPath: '/api',
  apiVersion: 'v1',
  scope: 'web',
  resourceType: 'product_images',
  attributes: [
    'id',
    'image',
    'original_filename',
    'product_id',
    'is_cover',
    'variant_id'
  ],
  editableAttributes: ['variant_id']
}

export default class ProductImage extends ResourceModelBase {
  constructor(attributes = {}) {
    super(OPTIONS, attributes)
  }

  setAsCover() {
    return axios.put(`${this.apiBasePath()}/${this.id}/set_as_cover`)
  }

  assignToVariant() {
    const requestBody = {
      data: {
        type: "product-image-assign-to-variant",
        attributes: {
          variant_id: this.variant_id
        }
      }
    }

    return axios.put(`${this.apiBasePath()}/${this.id}/assign_to_variant`, requestBody)
  }
  // extra methods or helpers here...
}
