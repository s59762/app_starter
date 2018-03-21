import UserModelBase from './base'
/**
 * User user model
 *
 * @export
 * @class User
 */
export default class User extends UserModelBase {
  constructor(jwtPayload) {
    super(jwtPayload)
  }
}
