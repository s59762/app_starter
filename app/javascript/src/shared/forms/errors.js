const DEFAULT_ERROR_OBJECT = { validation_errors: {} }

export default class Errors {
  /**
   * 建立 Errors 的 instance
   */
  constructor() {
    this.errors = DEFAULT_ERROR_OBJECT
  }

  /**
   * 檢查某個欄位是否有錯誤
   *
   * @param {string} columnName 欄位名稱
   */
  has(columnName) {
    return this.errors.validation_errors.hasOwnProperty(columnName)
  }

  /**
   * 檢查是否有任何錯誤
   */
  any() {
    return Object.keys(this.errors.validation_errors).length > 0
  }

  /**
   * 取得某個欄位的錯誤訊息內容
   *
   * @param {string} columnName
   */
  get(columnName) {
    if (this.errors.validation_errors[columnName]) {
      return this.errors.validation_errors[columnName]
    }
  }

  /**
   * 檢查欄位錯誤，回傳標示錯誤的 css class name
   *
   * @param {any} columnName 要檢查的欄位名稱
   * @returns {string} 若有欄位錯誤回傳 'is-danger'
   */
  errorClassAt(columnName) {
    return this.has(columnName) ? 'is-danger' : ''
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
   * @param {Object} errors axios 從 server 收到的 error 物件
   */
  record(errors) {
    if (errors.response.status === 422) {
      this.errors = errors.response.data
    }
  }

  /**
   * 清除某欄位或者全部的錯誤內容
   *
   * @param {string|null} columnName 若指定欄位名稱會指清除該欄位的錯誤，不指定則全部清除
   */
  clear(columnName) {
    if (columnName) {
      delete this.errors.validation_errors[columnName]

      return
    }

    this.errors = DEFAULT_ERROR_OBJECT
  }
}
