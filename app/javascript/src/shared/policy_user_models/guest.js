import ApplicationPolicyUserModel from './application_policy_user_model'
/**
 * Guest user model
 *
 * @export
 * @class Guest
 */
export default class Guest extends ApplicationPolicyUserModel {
  constructor(jwtPayload) {
    super({
      sub: '0',
      role: 'guest',
      type: jwtPayload.type,
      iat: jwtPayload.iat,
      exp: jwtPayload.exp
    })
  }
}
