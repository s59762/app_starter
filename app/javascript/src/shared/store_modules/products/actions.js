import * as types from './mutation-types'
import Product from '../../resource_models/product'

export const all = ({
  dispatch,
  commit
}, options) => {
  commit(types.API_REQUEST_START, 'all')

  return new Promise((resolve, reject) => {
    Product.all(options)
      .then(response => {
        commit(types.FETCH_PRODUCTS_SUCCESS, response)

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
    Product.find(id)
      .then(response => {
        commit(types.GET_PRODUCT_SUCCESS, response)
        dispatch('productVariants/receiveResourcesFromRelationships', response, {
          root: true
        })
        dispatch('productOptionTypes/receiveResourcesFromRelationships', response, {
          root: true
        })
        dispatch('productImages/receiveResourcesFromRelationships', response, {
          root: true
        })

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
    model
      .save()
      .then(response => {
        if (model.isNewRecord()) {
          commit(types.ADD_PRODUCT_SUCCESS, response)
        } else {
          commit(types.UPDATE_PRODUCT_SUCCESS, response)
        }
        dispatch('productVariants/receiveResourcesFromRelationships', response, {
          root: true
        })
        dispatch('productOptionTypes/receiveResourcesFromRelationships', response, {
          root: true
        })
        dispatch('productImages/receiveResourcesFromRelationships', response, {
          root: true
        })

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
    model
      .destroy()
      .then(response => {
        commit(types.DELETE_PRODUCT_SUCCESS, id)

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

export const uploadImages = ({
  dispatch,
  commit
}, formData) => {
  commit(types.API_REQUEST_START, 'uploadImages')

  return new Promise((resolve, reject) => {
    Product.uploadImages(formData)
      .then(response => {
        if (formData.get('product[product_id]')) {
          commit(types.UPDATE_PRODUCT_SUCCESS, response)
          dispatch('productVariants/receiveResourcesFromRelationships', response, {
            root: true
          })
          dispatch('productOptionTypes/receiveResourcesFromRelationships', response, {
            root: true
          })
          dispatch('productImages/receiveResourcesFromRelationships', response, {
            root: true
          })
        } else {
          commit(types.PRODUCT_IMAGE_UPLOAD_SUCCESS)
        }

        resolve(response)
      })
      .catch(errors => {
        commit(types.API_REQUEST_FAIL, errors)
        dispatch('errorMessageHandler', {
          errors,
          retryAction: uploadImages,
          ref: {
            dispatch,
            commit
          },
          params: formData
        }, {
          root: true
        })

        reject(errors)
      })
  })
}

export const uploadAttachments = ({
  dispatch,
  commit
}, formData) => {
  commit(types.API_REQUEST_START, 'uploadAttachments')

  return new Promise((resolve, reject) => {
    Product.uploadAttachments(formData)
      .then(response => {
        commit(types.PRODUCT_IMAGE_UPLOAD_SUCCESS)

        resolve(response)
      })
      .catch(errors => {
        commit(types.API_REQUEST_FAIL, errors)
        dispatch('errorMessageHandler', {
          errors,
          retryAction: uploadAttachments,
          ref: {
            dispatch,
            commit
          },
          params: formData
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
    commit(types.GET_RELATED_PRODUCTS_SUCCESS, response)

    resolve(response)
  })
}

export const receiveResourcesFromRelationshipsWithReplace = ({
  commit
}, response) => {
  return new Promise((resolve, reject) => {
    commit(types.FETCH_PRODUCTS_SUCCESS, response)

    resolve(response)
  })
}

export const getResourceFromRelationship = ({
  commit
}, response) => {
  return new Promise((resolve, reject) => {
    commit(types.GET_PRODUCT_SUCCESS, response)

    resolve(response)
  })
}
