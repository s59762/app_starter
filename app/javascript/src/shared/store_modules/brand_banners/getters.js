import BrandBanner from '../../resource_models/brand_banner'

export const isLoading = state => {
  return state.isCallingAPI
}

export const all = state => {
  if (state.result) {
    return state.result.map(id => new BrandBanner(state.entities[id]))
  }
}

export const find = state => id => {
  return new BrandBanner(state.entities[id])
}

export const meta = state => {
  return state.meta
}

export const errors = state => {
  return state.errors
}
