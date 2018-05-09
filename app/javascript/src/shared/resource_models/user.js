import ResourceModelBase from 'odd-resource_model'

const OPTIONS = {
  apiPath: '/api',
  apiVersion: 'v1',
  scope: 'web',
  resourceType: 'users',
  attributes: ['created_at', 'email', 'id', 'last_sign_in_at', 'sign_in_count', 'updated_at'],
  editableAttributes: ['email', 'new_password', 'password', 'password_confirmation']
}

export default class User extends ResourceModelBase {
  constructor(attributes = {}) {
    super(OPTIONS, attributes)
  }

  // extra methods or helpers here...
}
