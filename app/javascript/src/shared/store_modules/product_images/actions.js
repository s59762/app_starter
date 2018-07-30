import * as types from './mutation-types'
import ProductImage from '../../resource_models/product_image'

export const all = ({
  dispatch,
  commit
}, options) => {
  commit(types.API_REQUEST_START, 'all')

  return new Promise((resolve, reject) => {
    ProductImage.all(options)
      .then(response => {
        commit(types.FETCH_PRODUCT_IMAGES_SUCCESS, response)

        resolve(response)
      })
      .catch(errors => {
        commit(types.API_REQUEST_FAIL, errors)
        dispatch('errorMessageHandler', {
          errors,
          retryAction: all,
          ref: {
            dispatch,
            commit
          },
          params: options
        }, {
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
    ProductImage.find(id)
      .then(response => {
        commit(types.GET_PRODUCT_IMAGE_SUCCESS, response)

        resolve(response)
      })
      .catch(errors => {
        commit(types.API_REQUEST_FAIL, errors)
        dispatch('errorMessageHandler', {
          errors,
          retryAction: find,
          ref: {
            dispatch,
            commit
          },
          params: id
        }, {
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
          commit(types.ADD_PRODUCT_IMAGE_SUCCESS, response)
        } else {
          commit(types.UPDATE_PRODUCT_IMAGE_SUCCESS, response)
        }

        resolve(response)
      })
      .catch(errors => {
        model.errors.record(errors)
        commit(types.API_REQUEST_FAIL, errors)
        dispatch('errorMessageHandler', {
          errors,
          retryAction: save,
          ref: {
            dispatch,
            commit
          },
          params: model
        }, {
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
        commit(types.DELETE_PRODUCT_IMAGE_SUCCESS, model.id)

        resolve(response)
      })
      .catch(errors => {
        model.errors.record(errors)
        commit(types.API_REQUEST_FAIL, errors)
        dispatch('errorMessageHandler', {
          errors,
          retryAction: destroy,
          ref: {
            dispatch,
            commit
          },
          params: model
        }, {
          root: true
        })

        reject(errors)
      })
  })
}

export const setAsCover = ({
  dispatch,
  commit
}, model) => {
  commit(types.API_REQUEST_START, 'setAsCover')

  return new Promise((resolve, reject) => {
    model.setAsCover()
      .then(response => {
        commit(types.FETCH_PRODUCT_IMAGES_SUCCESS, response)

        resolve(response)
      })
      .catch(errors => {
        model.errors.record(errors)
        commit(types.API_REQUEST_FAIL, errors)
        dispatch('errorMessageHandler', {
          errors,
          retryAction: setAsCover,
          ref: {
            dispatch,
            commit
          },
          params: model
        }, {
          root: true
        })

        reject(errors)
      })
  })
}

export const assignToVariant = ({
  dispatch,
  commit
}, model) => {
  commit(types.API_REQUEST_START, 'assignToVariant')

  return new Promise((resolve, reject) => {
    model.assignToVariant()
      .then(response => {
        commit(types.GET_PRODUCT_IMAGE_SUCCESS, response)

        resolve(response)
      })
      .catch(errors => {
        commit(types.API_REQUEST_FAIL, errors)
        dispatch('errorMessageHandler', {
          errors,
          retryAction: assignToVariant,
          ref: {
            dispatch,
            commit
          },
          params: model
        }, {
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
    commit(types.GET_RELATED_PRODUCT_IMAGES_SUCCESS, response)

    resolve(response)
  })
}

export const getResourceFromRelationship = ({
  commit
}, response) => {
  return new Promise((resolve, reject) => {
    commit(types.GET_PRODUCT_IMAGE_SUCCESS, response)

    resolve(response)
  })
}
