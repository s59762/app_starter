import ModelBase from './base'

export default class User extends ModelBase {
  constructor() {
    super({ resource_type: 'users' })
  }
}
