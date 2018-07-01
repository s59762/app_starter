import ProductOptionType from '../../resource_models/product_option_type'

export const isLoading = state => {
  return state.isCallingAPI
}

export const all = state => {
  if (state.result) {
    return state.result.map(id => new ProductOptionType(state.entities[id]))
  }
}

export const find = state => id => {
  return new ProductOptionType(state.entities[id])
}

export const meta = state => {
  return state.meta
}

export const errors = state => {
  return state.errors
}
