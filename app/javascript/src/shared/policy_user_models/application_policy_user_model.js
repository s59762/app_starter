import PolicyUserModelBase from 'odd-policy_user_model'

/**
 * User model 基礎，包含了所有 User 都會用到的方法
 *
 * @export
 * @class UserModelBase
 */
export default class ApplicationPolicyUserModel extends PolicyUserModelBase {
  constructor(jwtPayload) {
    super(jwtPayload)
  }

  isGuest() {
    return this.role === 'guest'
  }

  isOwner() {
    return this.type === 'Admin' && this.role === 'owner'
  }

  isSuper() {
    return this.type === 'Admin' && this.role === 'super'
  }

  isStockManager() {
    return this.type === 'Admin' && this.role === 'stock_manager'
  }

  isAccounter() {
    return this.type === 'Admin' && this.role === 'accounter'
  }

  isContentManager() {
    return this.type === 'Admin' && this.role === 'content_manager'
  }
}
