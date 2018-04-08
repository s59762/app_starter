/**
 * 在 Quill editor 中處理關於圖片的操作。可把圖片上傳到自己的 server，並可從 server 刪除圖片。
 */
export default class ImageHandler {
  constructor(quill, options = {}) {
    this.quill = quill
    this.editor = this.quill.root
    this.editorContainer = this.editor.parentNode

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

    if (event.dataTransfer && event.dataTransfer.files && event.dataTransfer.files.length) {
      setInsertPositionViaCaret(event)
      base64encode(event.dataTransfer.files, this.insert.bind(this))
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
      // base64encode(clipboardData.items, this.insert.bind(this))
      // base64encode(event.clipboardData.items, dataUrl => {
      //   const selection = this.quill.getSelection()
      //   if (selection) {
      //     // we must be in a browser that supports pasting (like Firefox)
      //     // so it has already been placed into the editor
      //     setTimeout(() => {
      //       this.insert(dataUrl)
      //     }, 10)
      //   } else {
      //     console.log('ng')
      //     // otherwise we wait until after the paste when this.quill.getSelection()
      //     // will return a valid index
      //     setTimeout(() => this.insert(dataUrl), 0)
      //   }
      // })
    }
  }

  deleteHandler(delta, oldDelta, source) {
    // console.log(delta, oldDelta)
    false
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
 * 嘗試把 drop 或 paste 事件中的檔案讀取出來。僅針對圖片做處理。
 *
 * @param {File[]} files 事件中包含的檔案
 * @param {Function} callback 所有檔案的內容會透過這個 callback 傳送。
 */
function base64encode(files, callback) {
  ;[].forEach.call(files, file => {
    if (!file.type.match(/^image\/(gif|jpe?g|a?png)/i)) {
      return
    }

    const reader = new FileReader()

    reader.onload = event => {
      callback(event.target.result)
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
