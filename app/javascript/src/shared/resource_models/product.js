import ModelBase from './base'

export default class Product extends ModelBase {
  constructor() {
    super({ resource_type: 'products' })
  }
}
