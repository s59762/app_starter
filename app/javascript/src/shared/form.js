export default class Form {
  /**
   * 建立 Form 的 instance
   *
   * @param {object} data Form 需要的 attributes
   * @param {function} dispatcher vuex store dispatch function
   * @param {object} errors Errors instance in vuex store
   */
  constructor(data, dispatcher, errors) {
    this.originalData = data
    this.dispatcher = dispatcher
    this.errors = errors

    for (let field in data) {
      this[field] = data[field]
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
      this[field] = ''
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
   * 檢查欄位錯誤，回傳標示錯誤的 css class name
   *
   * @param {any} columnName 要檢查的欄位名稱
   * @returns {string} 若有欄位錯誤回傳 'is-danger'
   */
  errorClassAt(columnName) {
    return this.errors.has(columnName) ? 'is-danger' : ''
  }

  /**
   * 分發 action 到 vuex
   *
   * @param {any} actionName
   * @returns {object} 回傳 Promise 物件，成功的話回傳 response，失敗則回傳 errors 內容
   */
  dispatch(actionName, payload) {
    return new Promise((resolve, reject) => {
      this.dispatcher(actionName, payload)
        .then(response => {
          this.reset()

          resolve(response)
        })
        .catch(() => {
          reject(this.errors)
        })
    })
  }

  /**
   * 新增 flash message 到 vuex store，讓前端顯示訊息。
   *
   * @param {array} message 格式為 `['flashType', 'messageContent']`
   */
  addFlashMessage(message) {
    this.dispatcher('addFlashMessage', message)
  }
}
