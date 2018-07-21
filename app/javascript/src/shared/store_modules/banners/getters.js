import Banner from '../../resource_models/banner'

export const isLoading = state => {
  return state.isCallingAPI
}

export const all = state => {
  if (state.result) {
    return state.result.map(id => new Banner(state.entities[id]))
  }
}

export const useTypes = state => {
  return state.useTypes
}

export const allByType = state => type => {
  if (state.result) {
    return state.result.map(id => new Banner(state.entities[id])).filter(banner => banner.use_type === type)
  }
}

export const find = state => id => {
  return new Banner(state.entities[id])
}

export const meta = state => {
  return state.meta
}

export const errors = state => {
  return state.errors
}
