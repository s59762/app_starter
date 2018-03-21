import PolicyBase from './policy_base'

export default class DashboardPolicy extends PolicyBase {
  constructor(user) {
    super(user)
  }

  show() {
    return true
  }
}
