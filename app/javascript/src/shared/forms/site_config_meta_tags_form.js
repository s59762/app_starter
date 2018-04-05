import Form from '../form'

export default class SiteConfigMetaTagsFrom extends Form {
  constructor(model) {
    super({
      attributes: function() {
        return {}
      }
    })
    this.model = model
    this.originalData = {}

    for (let field in model.meta_tags) {
      this.originalData[field] = model.meta_tags[field]
      this[field] = model.meta_tags[field]
    }
  }

  sync() {
    for (let attr in this.model.meta_tags) {
      this.model.meta_tags[attr] = this[attr]
    }

    return this.model
  }
}
