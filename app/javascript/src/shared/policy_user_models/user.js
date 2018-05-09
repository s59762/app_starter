import ApplicationPolicyUserModel from './application_policy_user_model'
/**
 * User user model
 *
 * @export
 * @class User
 */
export default class User extends ApplicationPolicyUserModel {
  constructor(jwtPayload) {
    super(jwtPayload)
  }
}
