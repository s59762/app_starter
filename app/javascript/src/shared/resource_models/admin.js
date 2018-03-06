import ModelBase from './base'
import axios from 'axios'

export default class Admin extends ModelBase {
  constructor() {
    super({ resource_type: 'admins' })
  }

  /**
   * 從 server 取得所有 Admin 可用的 roles 列表
   *
   * @returns {promise}
   */
  roles() {
    return axios.get(
      `${this.api_base_path}/${this.api_version}/${this.scope}/${this.resource_type}/roles`
    )
  }

  suspend(id) {
    return axios.put(
      `${this.api_base_path}/${this.api_version}/${this.scope}/${this.resource_type}/${id}/suspend`
    )
  }

  /**
   * 把 admin roles 列表寫入 vuex store。
   */
  receiveAvailableRoles(state, response) {
    state.availableRoles = response.data.data
  }
}
