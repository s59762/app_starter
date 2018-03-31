import PolicyBase from './policy_base'

export default class DashboardPolicy extends PolicyBase {
  constructor(user, record = null) {
    super(user, record)
  }

  show() {
    return true
  }
}
