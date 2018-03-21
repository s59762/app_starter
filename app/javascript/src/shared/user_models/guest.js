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
      sub: null,
      type: 'Guest',
      role: 'guest'
    })
  }
}
