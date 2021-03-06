import FormBase from 'odd-form_object'

export default class AdminSiteConfigMetaTagsFrom extends FormBase {
  constructor(model) {
    super({
      attributes() {
        return model.meta_tags
      }
    })
    this.model = model

    this.constructor.dataAssigner(this.originalData, this)
  }

  sync() {
    this.constructor.dataDumper(this, this.model.meta_tags, this.originalData)

    return this.model
  }
}
