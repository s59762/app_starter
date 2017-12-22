export default class Errors {
  /**
   * 建立 Errors 的 instance
   */
  constructor() {
    this.errors = {}
  }

  /**
   * 檢查某個欄位是否有錯誤
   *
   * @param {string} columnName 欄位名稱
   */
  has(columnName) {
    return this.errors.hasOwnProperty(columnName)
  }

  /**
   * 檢查是否有任何錯誤
   */
  any() {
    return Object.keys(this.errors).length > 0
  }

  /**
   * 取得某個欄位的錯誤訊息內容
   *
   * @param {string} columnName
   */
  get(columnName) {
    if (this.errors[columnName]) {
      return this.errors[columnName]
    }
  }

  /**
   * 列出所有錯誤訊息內容
   *
   * @returns {Object} 所有錯誤訊息內容
   */
  all() {
    return this.errors
  }

  /**
   * 紀錄錯誤內容
   *
   * @param {object} errors
   */
  record(errors) {
    this.errors = errors
  }

  /**
   * 清除某欄位或者全部的錯誤內容
   *
   * @param {string|null} columnName 若指定欄位名稱會指清除該欄位的錯誤，不指定則全部清除
   */
  clear(columnName) {
    if (columnName) {
      delete this.errors[columnName]

      return
    }

    this.errors = {}
  }
}