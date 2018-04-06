import FormBase from './form_base'

export default class SiteConfigMetaTagsFrom extends FormBase {
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
