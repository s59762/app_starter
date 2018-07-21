import * as types from './mutation-types'
import Brand from '../../resource_models/brand'

export const all = ({
  dispatch,
  commit
}, options) => {
  commit(types.API_REQUEST_START, 'all')

  return new Promise((resolve, reject) => {
    Brand.all(options)
      .then(response => {
        commit(types.FETCH_BRANDS_SUCCESS, response)

        resolve(response)
      })
      .catch(errors => {
        commit(types.API_REQUEST_FAIL, errors)
        dispatch('errorMessageHandler', errors, {
          root: true
        })

        reject(errors)
      })
  })
}

export const find = ({
  dispatch,
  commit
}, id) => {
  commit(types.API_REQUEST_START, 'find')

  return new Promise((resolve, reject) => {
    Brand.find(id)
      .then(response => {
        commit(types.GET_BRAND_SUCCESS, response)

        resolve(response)
      })
      .catch(errors => {
        commit(types.API_REQUEST_FAIL, errors)
        dispatch('errorMessageHandler', errors, {
          root: true
        })

        reject(errors)
      })
  })
}

export const save = ({
  dispatch,
  commit
}, model) => {
  commit(types.API_REQUEST_START, 'save')

  return new Promise((resolve, reject) => {
    model.save()
      .then(response => {
        if (model.isNewRecord()) {
          commit(types.ADD_BRAND_SUCCESS, response)
        } else {
          commit(types.UPDATE_BRAND_SUCCESS, response)
        }

        resolve(response)
      })
      .catch(errors => {
        model.errors.record(errors)
        commit(types.API_REQUEST_FAIL, errors)
        dispatch('errorMessageHandler', errors, {
          root: true
        })

        reject(errors)
      })
  })
}

export const destroy = ({
  dispatch,
  commit
}, model) => {
  commit(types.API_REQUEST_START, 'destroy')

  return new Promise((resolve, reject) => {
    model.destroy()
      .then(response => {
        commit(types.DELETE_BRAND_SUCCESS, model.id)

        resolve(response)
      })
      .catch(errors => {
        model.errors.record(errors)
        commit(types.API_REQUEST_FAIL, errors)
        dispatch('errorMessageHandler', errors, {
          root: true
        })

        reject(errors)
      })
  })
}

export const updateLogo = ({
  dispatch,
  commit
}, {
  model,
  formData
}) => {
  commit(types.API_REQUEST_START, 'updateLogo')

  return new Promise((resolve, reject) => {
    model.updateLogo(formData)
      .then(response => {
        commit(types.UPDATE_BRAND_SUCCESS, response)

        resolve(response)
      })
      .catch(errors => {
        model.errors.record(errors)
        commit(types.API_REQUEST_FAIL, errors)
        dispatch('errorMessageHandler', errors, {
          root: true
        })

        reject(errors)
      })
  })
}

export const fetchProducts = ({
  dispatch,
  commit
}, {
  model,
  options
}) => {
  commit(types.API_REQUEST_START, 'fetchProducts')

  return new Promise((resolve, reject) => {
    model.fetchProducts(options)
      .then(response => {
        dispatch('products/receiveResourcesFromRelationshipsWithReplace', response, {
          root: true
        })
        commit(types.FETCH_BRAND_PRODUCTS_SUCCESS)

        resolve(response)
      })
      .catch(errors => {
        commit(types.API_REQUEST_FAIL, errors)
        dispatch('errorMessageHandler', errors, {
          root: true
        })

        reject(errors)
      })
  })
}

export const fetchBanners = ({
  dispatch,
  commit
}, {
  model,
  options
}) => {
  commit(types.API_REQUEST_START, 'fetchBanners')

  return new Promise((resolve, reject) => {
    model.fetchBanners(options)
      .then(response => {
        dispatch('brandBanners/receiveResourcesFromRelationships', response, {
          root: true
        })
        commit(types.FETCH_BRAND_BANNERS_SUCCESS)

        resolve(response)
      })
      .catch(errors => {
        commit(types.API_REQUEST_FAIL, errors)
        dispatch('errorMessageHandler', errors, {
          root: true
        })

        reject(errors)
      })
  })
}


export const receiveResourcesFromRelationships = ({
  commit
}, response) => {
  return new Promise((resolve, reject) => {
    commit(types.GET_RELATED_BRANDS_SUCCESS, response)

    resolve(response)
  })
}

export const getResourceFromRelationship = ({
  commit
}, response) => {
  return new Promise((resolve, reject) => {
    commit(types.GET_BRAND_SUCCESS, response)

    resolve(response)
  })
}
