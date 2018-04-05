export default class Form {
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

    for (let field in this.originalData) {
      this[field] = this.originalData[field]
    }
  }

  /**
   * 列出所有 attributes
   */
  data() {
    let data = {}

    for (let property in this.originalData) {
      data[property] = this[property]
    }

    return data
  }

  /**
   * 重置 Form
   */
  reset() {
    for (let field in this.originalData) {
      this[field] = this.originalData[field]
    }

    this.errors.clear()
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
    for (let attr in this.originalData) {
      this.model[attr] = this[attr]
    }

    return this.model
  }
}
