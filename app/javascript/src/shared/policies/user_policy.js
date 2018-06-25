import PolicyBase from './policy_base'

export default class UserPolicy extends PolicyBase {
  constructor(user, record = null) {
    super(user, record)
  }

  index() {
    return this.forAdminOwnerAndSuperAndAccounterOnly()
  }

  show() {
    return this.forAdminOwnerAndSuperAndAccounterOrUserSelfOnly()
  }

  collections() {
    if (this.isAdmin()) {
      return false
    } else {
      return true
    }
  }

  // helpers

  forAdminOwnerAndSuperAndAccounterOnly() {
    if (this.isAdmin()) {
      return this.user.isOwner() || this.user.isSuper() || this.user.isAccounter()
    } else {
      return false
    }
  }

  forAdminOwnerAndSuperAndAccounterOrUserSelfOnly() {
    if (this.isAdmin()) {
      return this.user.isOwner() || this.user.isSuper() || this.user.isAccounter()
    } else {
      return this.record.id === this.user.id
    }
  }
}
