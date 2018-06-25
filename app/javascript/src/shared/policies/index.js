import BrandPolicy from './brand_policy'
import UserPolicy from './user_policy'
import AdminPolicy from './admin_policy'
import DashboardPolicy from './dashboard_policy'

const POLICIES = {
  brand: BrandPolicy,
  user: UserPolicy,
  admin: AdminPolicy,
  dashboard: DashboardPolicy
}

export default POLICIES
