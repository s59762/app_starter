import swal from 'sweetalert2'

/**
 * 提供透過 Sweetalert 來確認動作的功能
 *
 * @export
 * @class ActionConfirmService
 */
export default class ActionConfirmService {
  /**
   * 初始化 sweetalert 的內容
   * @param {Object} [options={}] scope, title, text, type, showCancelButton, confirmButtonText, cancelButtonText, customClass
   * @memberof ActionConfirmService
   */
  constructor(options = {}) {
    this.scope = options.scope || 'admin'
    this.title = options.title || I18n.t(`messages.confirmations.please_confirm_your_operation_first`)
    this.text = options.text || I18n.t(`messages.confirmations.are_you_sure_want_to_continue`)
    this.type = options.type || 'warning'
    this.showCancelButton = options.showCancelButton || true
    this.confirmButtonText = options.confirmButtonText || I18n.t(`actions.${this.scope}.confirm`)
    this.cancelButtonText = options.cancelButtonText || I18n.t(`actions.${this.scope}.cancel`)
    this.animation = options.customClass ? false : true
    this.customClass = options.customClass || ''
  }

  /**
   * 確認是否要執行動作
   *
   * @param {Function} callback 帶入一個 function，若使用者確認的話可直接執行
   * @param {any} [cancelCallback=null] 可選擇性地帶入一個 function 在使用者選擇取消動作時執行，若不帶入則不做任何動作
   * @memberof ActionConfirmService
   */
  confirm(callback, cancelCallback = null) {
    swal({
      title: this.title,
      text: this.text,
      type: this.type,
      showCancelButton: this.showCancelButton,
      confirmButtonText: this.confirmButtonText,
      cancelButtonText: this.cancelButtonText,
      animation: this.animation,
      customClass: this.customClass
    }).then(result => {
      if (result.value) {
        callback()
      } else {
        if (cancelCallback) {
          cancelCallback()
        }
      }
    })
  }
}
