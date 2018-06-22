// private methods

/**
 * 檢查 paste or drop 的檔案是否本身為 data-uri 或 image link，若是的話透過 Promise#resolve
 * 回傳檔案內容或連結的的 string；反之透過 Promise#reject 告知檔案需自行上傳或轉為 base64
 *
 * @export
 * @param {Array} files 從 paste or drop 事件得到的檔案
 * @returns Promise object
 */
export function _checkForOwnImageUrl(files) {
  return new Promise((resolve, reject) => {
    if (files[0].kind === 'string') {
      files[0].getAsString(string => {
        if (string.split('/')[0].match(/^data:image|^https?:/i)) {
          resolve(string)
        } else if (string.match(/^<img/)) {
          resolve(string.match(/\ssrc\s*=\s*['|"](.+?)['|"]/)[1])
        } else {
          reject()
        }
      })
    } else {
      reject()
    }
  })
}

/**
 * 建立 formData 物件
 *
 * @param {Array} files 從 paste of drop 事件得到的檔案
 * @param {string} 指定的圖片表單 name attribute
 * @param {Function} 以 callback 的方式讓 FormData 可以加上額外的欄位
 * @returns {Object} 回傳建立好的 FormData 物件
 */
export function _generateFormData(files, imagesAttrName, additionalFormData) {
  let formData = new FormData();
  [].forEach.call(files, file => {
    const blob = file.getAsFile ? file.getAsFile() : file

    if (blob instanceof Blob) {
      formData.append(imagesAttrName, blob)
    }
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
export function _base64encode(files, callback) {
  let originalUrl = false

  // 在 paste 事件中，若 clipboard 中的檔案原本就擁有自己的 url 或 dataUrl，記錄到 origianlUrl 變數中
  if (files[0].kind === 'string') {
    files[0].getAsString(string => {
      if (string.split('/')[0].match(/^data:image|^https?:/i)) {
        originalUrl = string
      } else if (string.match(/^<img/)) {
        originalUrl = string.match(/\ssrc\s*=\s*['|"](.+?)['|"]/)[1]
      }
    })
  }

  // 找出事件中的 file 物件，若是圖片則進行處理
  ;
  [].forEach.call(files, file => {
    if (!file.type.match(/^image\/(gif|jpe?g|a?png)/i)) {
      return
    }

    const reader = new FileReader()

    // FileReader onload 時
    // 若這次 paste 事件有原始的 url，則使用原始資料來插入圖片
    // 反之則使用 base64
    reader.onload = event => {
      if (originalUrl) {
        // console.log('USE ORIGINAL')
        callback(originalUrl)
      } else {
        // console.log('USE BASE64')
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
 * @param {Event} event 瀏覽器的 Event 物件
 */
export function _setInsertPositionViaCaret(event) {
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
