/**
 * Policy Object Base
 *
 * @export
 * @class PolicyBase
 */
export default class PolicyBase {
  constructor(user, record = null) {
    this.user = user
    this.record = record
  }

  index() {
    return false
  }

  show() {
    return false
  }

  create() {
    return false
  }

  update() {
    return false
  }

  destroy() {
    return false
  }
}
