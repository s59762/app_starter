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

  confirm(callback) {
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
      }
    })
  }
}
