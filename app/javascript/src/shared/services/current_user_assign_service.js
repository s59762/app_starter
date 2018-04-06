import JwtManageService from './jwt_manage_service'
import Admin from '../user_models/admin'
import User from '../user_models/user'
import Guest from '../user_models/guest'

/**
 * 在 vuex 中建立 currentUser state
 *
 * @export
 * @class CurrentUserAssignService
 */
export default class CurrentUserAssignService {
  /**
   * Creates an instance of CurrentUserAssignService.
   *
   * @param {any} scope application 的 scope。例如可能在後台會是 `admin`，前台會是 `user`
   */
  constructor(scope) {
    this.jwt = JwtManageService.getJWT(scope)
    this.payload = JwtManageService.getPayload(scope)
  }

  /**
   * 根據 jwt 中不同的 user type，回傳相應的 js user model
   *
   * @returns
   * @memberof CurrentUserAssignService
   */
  getCurrentUser() {
    switch (this.payload.type) {
      case 'Admin':
        return new Admin(this.payload)
        break
      case 'User':
        return new User(this.payload)
        break
      default:
        return new Guest()
    }
  }

  static call(scope) {
    return new CurrentUserAssignService(scope).getCurrentUser()
  }
}
