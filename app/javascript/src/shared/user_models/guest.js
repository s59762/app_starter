import UserModelBase from './base'
/**
 * Guest user model
 *
 * @export
 * @class Guest
 */
export default class Guest extends UserModelBase {
  constructor() {
    super({
      sub: 0,
      type: 'Guest',
      role: 'guest'
    })
  }
}
