/**
 * 在 Quill editor 中處理關於圖片的操作。可把圖片上傳到自己的 server，並可從 server 刪除圖片。
 */
export default class ImageHandler {
  constructor(quill, options = {}) {
    this.quill = quill
    this.editor = this.quill.root
    this.editorContainer = this.editor.parentNode

    this.dispatch = options.dispatcher || null
    this.action = options.action || null
    this.imagesAttrName = options.imagesAttrName || 'image[]'
    this.additionalFormData = options.additionalFormData

    // 監聽在 Editor 中發生的 `click`, `paste`, 和 `drop` 事件。
    this.editor.addEventListener('click', this.clickHandler.bind(this), false)
    this.editor.addEventListener('paste', this.pasteHandler.bind(this), false)
    this.editor.addEventListener('drop', this.dropHandler.bind(this), false)
    this.quill.on('text-change', this.deleteHandler)
    console.log(options)
  }

  /**
   * 若拖放事件中包含了 image 時介入處理
   *
   * @param {Event} event 瀏覽器的 Event 事件物件
   */
  dropHandler(event) {
    event.preventDefault()
    event.stopPropagation()

    if (event.dataTransfer && event.dataTransfer.files && event.dataTransfer.files.length) {
      setInsertPositionViaCaret(event)
      this.imageHandler(event.dataTransfer.files)
    }
  }

  /**
   * 若點擊事件發生在 image 身上時介入處理
   *
   * @param {Event} event 瀏覽器的 Event 事件物件
   */
  clickHandler(event) {
    // console.log(event)
  }

  /**
   * 若貼上事件中包含了 image 時介入處理
   *
   * @param {Event} event 瀏覽器的 Event 事件物件
   */
  pasteHandler(event) {
    const clipboardData = event.clipboardData

    if (clipboardData && clipboardData.items && clipboardData.items.length) {
      event.preventDefault()
      event.stopPropagation()
      this.imageHandler(clipboardData.items)
    }
  }

  deleteHandler(delta, oldDelta, source) {
    // console.log(delta, oldDelta)
    false
  }

  /**
   * 處理從 paste 或 drop 事件得到的檔案
   *
   * @param {any} files
   * @memberof ImageHandler
   */
  imageHandler(files) {
    // 若有透過 module options 設定 vuex dispatcher 和指定的 action，則透過 vuex 上傳圖片
    if (this.dispatch && this.action) {
      let formData = generateFormData(files, this.imagesAttrName, this.additionalFormData)

      this.dispatch(this.action, formData).then(response => {
        response.data.data.forEach(image => {
          this.insert(image.attributes.url)
        })
      })
      // 否則使用 base64 處理圖片
    } else {
      base64encode(files, this.insert.bind(this))
    }
  }

  /**
   * 把圖片插入 Editor 的正確位置。
   * 若找不到 selection 的 index 時，把圖片放在文件的最後面（可能會發生在 Firefox，editor on blur 時）
   *
   * @param {String} dataUrl base64 DataUrl or image path
   */
  insert(dataUrl) {
    let cursorIndex = (this.quill.getSelection() || {}).index

    if (cursorIndex === undefined) {
      cursorIndex = this.quill.getLength()
    }

    this.quill.insertEmbed(cursorIndex, 'image', dataUrl, 'user')
    this.quill.setSelection(cursorIndex + 1)
  }
}

// private methods

/**
 * 建立 formData 物件
 *
 * @param {Array} files 從 paste of drop 事件得到的檔案
 * @param {string} 指定的圖片表單 name attribute
 * @param {Function} 以 callback 的方式讓 FormData 可以加上額外的欄位
 * @returns {Object} 回傳建立好的 FormData 物件
 */
function generateFormData(files, imagesAttrName, additionalFormData) {
  let formData = new FormData()
  ;[].forEach.call(files, file => {
    formData.append(imagesAttrName, file)
  })

  additionalFormData(formData)

  return formData
}

/**
 * 嘗試把 drop 或 paste 事件中的檔案讀取出來。僅針對圖片做處理。
 *
 * @param {File[]} files 事件中包含的檔案
 * @param {Function} callback 所有檔案的內容會透過這個 callback 傳送。
 */
function base64encode(files, callback) {
  let originalUrl = false

  // 在 paste 事件中，若 clipboard 中的檔案原本就擁有自己的 url 或 dataUrl，記錄到 origianlUrl 變數中
  if (files[0].kind === 'string') {
    files[0].getAsString(string => {
      if (string.split('/')[0].match(/data:image|https?:/i)) {
        originalUrl = string
      }
    })
  }

  // 找出事件中的 file 物件，若是圖片則進行處理
  ;[].forEach.call(files, file => {
    if (!file.type.match(/^image\/(gif|jpe?g|a?png)/i)) {
      return
    }

    const reader = new FileReader()

    // FileReader onload 時
    // 若這次 paste 事件有原始的 url，則使用原始資料來插入圖片
    // 反之則使用 base64
    reader.onload = event => {
      if (originalUrl) {
        console.log('USE ORIGINAL')
        callback(originalUrl)
      } else {
        console.log('USE BASE64')
        callback(event.target.result)
      }
    }

    // 嘗試把貼上的內容（DataTransferItem）透過 `#getAsFile` 取出檔案
    const blob = file.getAsFile ? file.getAsFile() : file
    if (blob instanceof Blob) {
      reader.readAsDataURL(blob)
    }
  })
}

/**
 * 嘗試從拖拉產生的游標位置決定 image 要插入到哪個位置。
 * `document.caretRangeFromPoint()` 可支援 WebKit 核心的瀏覽器
 * `document.caretPositionFromPoint()` 可支援 Firefox
 *
 * @param {Event} event 瀏覽器的 Event 事件物件
 */
function setInsertPositionViaCaret(event) {
  if (document.caretRangeFromPoint) {
    const selection = document.getSelection()
    const range = document.caretRangeFromPoint(event.clientX, event.clientY)

    if (selection && range) {
      selection.setBaseAndExtent(range.startContainer, range.startOffset, range.startContainer, range.startOffset)
    }
  }

  if (document.caretPositionFromPoint) {
    const selection = document.getSelection()
    const caretPosition = document.caretPositionFromPoint(event.clientX, event.clientY)

    if (selection && caretPosition) {
      selection.setBaseAndExtent(
        caretPosition.offsetNode,
        caretPosition.offset,
        caretPosition.offsetNode,
        caretPosition.offset
      )
    }
  }
}
