/**
 * User model 基礎，包含了所有 User 都會用到的方法
 *
 * @export
 * @class UserModelBase
 */
export default class UserModelBase {
  constructor(jwtPayload) {
    this.id = jwtPayload.sub
    this.role = jwtPayload.role
    this.type = jwtPayload.type
    this.issuedAt = jwtPayload.iat
    this.expiredAt = jwtPayload.exp
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
