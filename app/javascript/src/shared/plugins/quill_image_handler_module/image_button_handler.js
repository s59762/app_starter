export default function imageButtonHandler(options = {}) {
  let quill = options.quill
  let dispatch = options.dispatcher || null
  let action = options.action || null
  let imagesAttrName = options.imagesAttrName || 'image[]'
  let additionalFormData = options.additionalFormData
  let fileInput = document.querySelector('.quill-image-input')

  if (fileInput === null) {
    fileInput = document.createElement('input')
    fileInput.setAttribute('type', 'file')
    fileInput.setAttribute('multiple', true)
    fileInput.classList.add('quill-image-input')
    fileInput.style.display = 'none'

    fileInput.addEventListener('change', function() {
      let files = fileInput.files
      let formData = _generateFormData(files, imagesAttrName, additionalFormData)

      dispatch(action, formData).then(response => {
        response.data.data.forEach(image => {
          insertImage(quill, image.attributes.url)
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
function insertImage(quill, dataUrl) {
  let cursorIndex = (quill.getSelection() || {}).index

  if (cursorIndex === undefined) {
    cursorIndex = quill.getLength()
  }

  quill.insertEmbed(cursorIndex, 'image', dataUrl, 'user')
  quill.setSelection(cursorIndex + 1)
}

/**
 * 建立 formData 物件
 *
 * @param {Array} files 從 paste of drop 事件得到的檔案
 * @param {string} 指定的圖片表單 name attribute
 * @param {Function} 以 callback 的方式讓 FormData 可以加上額外的欄位
 * @returns {Object} 回傳建立好的 FormData 物件
 */
function _generateFormData(files, imagesAttrName, additionalFormData) {
  let formData = new FormData()
  ;[].forEach.call(files, file => {
    formData.append(imagesAttrName, file)
  })

  additionalFormData(formData)

  return formData
}
