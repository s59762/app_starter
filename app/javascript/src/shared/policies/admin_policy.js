import PolicyBase from './policy_base'

export default class AdminPolicy extends PolicyBase {
  constructor(user, record = null) {
    super(user, record)
  }

  index() {
    return this.forAdminOwnerAndSuperOnly()
  }

  show() {
    return this.forAdminOwnerAndSuperOrSelfOnly()
  }

  roles() {
    return this.forAdminOwnerAndSuperOnly()
  }

  create() {
    return this.forAdminOwnerAndSuperOnly()
  }

  update() {
    return this.forAdminOwnerAndSuperOnly()
  }

  suspend() {
    return this.forAdminOwnerAndSuperOnly()
  }

  // helpers

  forAdminOwnerAndSuperOrSelfOnly() {
    if (this.isAdmin()) {
      return this.user.isOwner() || this.user.isSuper() || this.record.id === this.user.id
    } else {
      return false
    }
  }
}
