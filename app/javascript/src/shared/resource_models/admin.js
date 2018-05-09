import axios from 'axios'
import ResourceModelBase from 'odd-resource_model'

const OPTIONS = {
  apiPath: '/api',
  apiVersion: 'v1',
  scope: 'web',
  resourceType: 'admins',
  attributes: [
    'avatar',
    'created_at',
    'email',
    'id',
    'is_suspended',
    'last_sign_in_at',
    'name',
    'role',
    'sing_in_count',
    'updated_at'
  ],
  editableAttributes: ['email', 'name', 'new_password', 'password', 'password_confirmation', 'role']
}

export default class Admin extends ResourceModelBase {
  constructor(attributes = {}) {
    super(OPTIONS, attributes)
  }

  /**
   * 從 server 取得所有 Admin 可用的 roles 列表
   *
   * @returns {promise}
   */
  static roles() {
    return axios.get(`${new this().apiBasePath()}/roles`)
  }

  /**
   * 將此 admin 停權
   *
   * @returns {Promise} 回傳 response 或 errors
   */
  suspend() {
    return axios.put(`${this.apiBasePath()}/${this.id}/suspend`)
  }
}
