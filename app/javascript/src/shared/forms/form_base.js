export default class FormBase {
  /**
   * 建立 Form 的 instance
   *
   * @param {Object} data Form 需要的 attributes
   * @param {function} dispatcher vuex store dispatch function
   * @param {Object} errors Errors instance in vuex store
   */
  constructor(model) {
    this.model = model
    this.originalData = model.attributes()

    this.constructor.dataAssigner(this.originalData, this)
  }

  /**
   * 列出所有 attributes
   */
  data() {
    let data = {}

    return this.constructor.dataDumper(this, data, this.originalData)
  }

  /**
   * 重置 Form
   */
  reset() {
    this.constructor.dataAssigner(this.originalData, this)
  }

  /**
   * 檢查欄位是否有填寫內容
   *
   * @param {string} columnName 要檢查的欄位名稱
   * @returns {boolean}
   */
  hasContent(columnName) {
    return this[columnName].length > 0
  }

  /**
   * 把使用者填寫的資料 sync 到 model 中
   *
   * @return {Object} model object
   * @memberof Form
   */
  sync() {
    return this.constructor.dataDumper(this, this.model, this.originalData)
  }

  static dataAssigner(source, target) {
    for (let key in source) {
      target[key] = source[key]
    }
  }

  static dataDumper(source, target, originalData) {
    for (let key in originalData) {
      target[key] = source[key]
    }

    return target
  }
}
