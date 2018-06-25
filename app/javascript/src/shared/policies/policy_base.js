/**
 * Policy Object Base
 *
 * @export
 * @class PolicyBase
 */
export default class PolicyBase {
  constructor(user, record) {
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

  // helpers

  isAdmin() {
    return this.user.type === 'Admin'
  }

  isUser() {
    return this.user.type === 'User'
  }

  isGuest() {
    return this.user.type === 'Guest'
  }

  forAdminOwnerAndSuperOnly() {
    if (this.isAdmin()) {
      return this.user.isOwner() || this.user.isSuper()
    } else {
      return false
    }
  }
}
