import { _generateFormData } from './utils'

const DEFAULT_OPTIONS = {
  quill: null,
  dispatcher: null,
  action: null,
  imagesAttrName: 'image[]',
  additionalFormData: null
}

export default function imageButtonHandler(options = {}) {
  options = Object.assign({}, DEFAULT_OPTIONS, options)

  let quill = options.quill
  let dispatch = options.dispatcher
  let action = options.action
  let imagesAttrName = options.imagesAttrName
  let additionalFormData = options.additionalFormData
  let fileInput = document.querySelector('.quill-image-input')

  if (fileInput === null) {
    fileInput = document.createElement('input')
    fileInput.setAttribute('type', 'file')
    fileInput.setAttribute('multiple', true)
    fileInput.classList.add('quill-image-input')
    fileInput.id = 'quill-image-input'
    fileInput.style.display = 'none'

    fileInput.addEventListener('change', function() {
      let files = fileInput.files
      let formData = _generateFormData(files, imagesAttrName, additionalFormData)

      dispatch(action, formData).then(response => {
        response.data.data.forEach(image => {
          _insertImage(quill, image.attributes.url)
        })
      })

      fileInput.value = ''
    })

    document.body.appendChild(fileInput)
  }

  fileInput.click()
}

/**
 * 插入圖片
 *
 * @param {any} quill Quill editor instance
 * @param {any} dataUrl image path or dataURL
 */
function _insertImage(quill, dataUrl) {
  let cursorIndex = (quill.getSelection() || {}).index

  if (cursorIndex === undefined) {
    cursorIndex = quill.getLength()
  }

  quill.insertEmbed(cursorIndex, 'image', dataUrl, 'user')
  quill.setSelection(cursorIndex + 1)
}
