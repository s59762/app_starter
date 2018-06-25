import PolicyBase from './policy_base'

export default class ProductCategoryPolicy extends PolicyBase {
  constructor(user, record = null) {
    super(user, record)
  }

  index() {
    return true
  }

  show() {
    return true
  }

  create() {
    return this.forAdminOwnerAndSuperAndStockManagerOnly()
  }

  update() {
    return this.forAdminOwnerAndSuperAndStockManagerOnly()
  }

  // helpers

  forAdminOwnerAndSuperAndStockManagerOnly() {
    if (this.isAdmin()) {
      return this.user.isOwner() || this.user.isSuper() || this.user.isStockManager()
    } else {
      return false
    }
  }
}
