import axios from 'axios'
import ResourceModelBase from 'odd-resource_model'

const OPTIONS = {
  apiPath: '/api',
  apiVersion: 'v1',
  scope: 'web',
  resourceType: 'site_config',
  attributes: ['meta_tags'],
  editableAttributes: ['meta_tags']
}

export default class SiteConfig extends ResourceModelBase {
  constructor(attributes = {}) {
    super(OPTIONS, attributes)
  }

  updateMetaTags() {
    return axios.put(`${this.apiBasePath()}/meta_tags`, this.metaTagsRequestBody())
  }

  // helpers

  metaTagsRequestBody() {
    return {
      data: {
        type: OPTIONS.resourceType,
        attributes: this.meta_tags
      }
    }
  }
}
