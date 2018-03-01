import ModelBase from './base'

export default class Admin extends ModelBase {
  constructor() {
    super({ resource_type: 'admins' })
  }
}
