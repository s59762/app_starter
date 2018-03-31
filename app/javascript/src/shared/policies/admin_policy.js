import PolicyBase from './policy_base'

export default class AdminPolicy extends PolicyBase {
  constructor(user, record = null) {
    super(user, record)
  }

  index() {
    if (this.user.type === 'Admin') {
      return this.user.isSuper() || this.user.isOwner()
    } else {
      return false
    }
  }

  roles() {
    if (this.user.type === 'Admin') {
      return this.user.isSuper() || this.user.isOwner()
    } else {
      return false
    }
  }

  create() {
    if (this.user.type === 'Admin') {
      return this.user.isSuper() || this.user.isOwner()
    } else {
      return false
    }
  }

  update() {
    if (this.user.type === 'Admin') {
      return this.user.isSuper() || this.user.isOwner()
    } else {
      return false
    }
  }

  suspend() {
    if (this.user.type === 'Admin') {
      return this.user.isSuper() || this.user.isOwner()
    } else {
      return false
    }
  }
}
