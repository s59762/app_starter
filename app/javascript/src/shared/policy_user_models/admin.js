import ApplicationPolicyUserModel from './application_policy_user_model'
/**
 * Admin user model
 *
 * @export
 * @class Admin
 */
export default class Admin extends ApplicationPolicyUserModel {
  constructor(jwtPayload) {
    super(jwtPayload)
  }
}
