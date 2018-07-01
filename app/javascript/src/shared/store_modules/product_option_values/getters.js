import ProductOptionValue from '../../resource_models/product_option_value'

export const isLoading = state => {
  return state.isCallingAPI
}

export const all = state => {
  if (state.result) {
    return state.result.map(id => new ProductOptionValue(state.entities[id]))
  }
}

export const find = state => id => {
  return new ProductOptionValue(state.entities[id])
}

export const meta = state => {
  return state.meta
}

export const errors = state => {
  return state.errors
}
