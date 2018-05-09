import ApplicationPolicyUserModel from './application_policy_user_model'
/**
 * Guest user model
 *
 * @export
 * @class Guest
 */
export default class Guest extends ApplicationPolicyUserModel {
  constructor() {
    super({
      sub: 0,
      type: 'Guest',
      role: 'guest'
    })
  }
}
