import UserModelBase from './base'
/**
 * Admin user model
 *
 * @export
 * @class Admin
 */
export default class Admin extends UserModelBase {
  constructor(jwtPayload) {
    super(jwtPayload)
  }
}
