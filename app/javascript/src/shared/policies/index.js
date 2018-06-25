import UserPolicy from './user_policy'
import AdminPolicy from './admin_policy'
import DashboardPolicy from './dashboard_policy'

const POLICIES = {
  user: UserPolicy,
  admin: AdminPolicy,
  dashboard: DashboardPolicy
}

export default POLICIES
