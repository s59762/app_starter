import Cookies from 'js-cookie'
import moment from 'moment'

/**
 * 處理 JWT 專用的 Service
 *
 * @export
 * @class JwtManageService
 */
export default class JwtManageService {
  /**
   * 從 Cookie 取得 JWT
   *
   * @static
   * @param {any} scope 前端 application 的 scope
   * @returns {string}
   */
  static getJWT(scope) {
    return Cookies.get(`${scope}_jwt`) || ''
  }

  /**
   * 從當前的 JWT 來產生 HTTP Header `Authorization` 的內容
   *
   * @static
   * @param {any} scope 前端 application 的 scope
   * @returns {string}
   */
  static getAuthorizationHeader(scope) {
    if (this.getJWT(scope)) {
      return `Bearer ${this.getJWT(scope)}`
    } else {
      return ''
    }
  }

  /**
   * 從當前的 JWT 取出 payload，並解碼成 js object.
   *
   * @static
   * @param {any} scope 前端 application 的 scope
   * @returns {object}
   */
  static getPayload(scope) {
    if (this.getJWT(scope)) {
      const payload = this.getJWT(scope).split('.')[1]

      return JSON.parse(atob(payload))
    } else {
      return {}
    }
  }

  /**
   * 若 JWT 過期則 reload page 嘗試更新 token
   *
   * @static
   * @param {any} scope
   */
  static checkJwt(scope) {
    const expireTime = this.getPayload(scope).exp
    const currentTime = moment().unix()

    if (currentTime > expireTime) {
      window.location.reload()
    }
  }
}
