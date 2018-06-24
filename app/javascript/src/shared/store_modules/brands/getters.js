import Brand from '../../resource_models/brand'

export const isLoading = state => {
  return state.isCallingAPI
}

export const all = state => {
  if (state.result) {
    return state.result.map(id => new Brand(state.entities[id]))
  }
}

export const find = state => id => {
  return new Brand(state.entities[id])
}

export const meta = state => {
  return state.meta
}

export const errors = state => {
  return state.errors
}
