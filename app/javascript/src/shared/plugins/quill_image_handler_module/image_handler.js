import { _generateFormData, _base64encode, _setInsertPositionViaCaret } from './utils'

const DEFAULT_OPTIONS = {
  dispatcher: null,
  action: null,
  imagesAttrName: 'image[]',
  additionalFormData: null
}

/**
 * 在 Quill editor 中處理關於圖片的操作。可把圖片上傳到自己的 server，並可從 server 刪除圖片。
 */
export default class ImageHandler {
  constructor(quill, options = {}) {
    options = Object.assign({}, DEFAULT_OPTIONS, options)

    this.quill = quill
    this.editor = this.quill.root
    this.editorContainer = this.editor.parentNode

    this.dispatch = options.dispatcher
    this.action = options.action
    this.imagesAttrName = options.imagesAttrName
    this.additionalFormData = options.additionalFormData

    // 監聽在 Editor 中發生的 `click`, `paste`, 和 `drop` 事件。
    this.editor.addEventListener('click', this.clickHandler.bind(this), false)
    this.editor.addEventListener('paste', this.pasteHandler.bind(this), false)
    this.editor.addEventListener('drop', this.dropHandler.bind(this), false)
    this.quill.on('text-change', this.deleteHandler)
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
      _setInsertPositionViaCaret(event)
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
      let formData = _generateFormData(files, this.imagesAttrName, this.additionalFormData)

      this.dispatch(this.action, formData).then(response => {
        response.data.data.forEach(image => {
          this.insert(image.attributes.url).bind(this)
        })
      })
      // 否則使用 base64 處理圖片
    } else {
      _base64encode(files, this.insert.bind(this))
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
      cursorIndex = quill.getLength()
    }

    this.quill.insertEmbed(cursorIndex, 'image', dataUrl, 'user')
    this.quill.setSelection(cursorIndex + 1)
  }
}
