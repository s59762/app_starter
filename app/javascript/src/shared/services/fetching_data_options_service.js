const DEFAULT_PAGE_SIZE = 25

/**
 * 提供 parse 關於 fetching data options 的功能
 *
 * @export
 * @class FetchingDataOptionsService
 */
export default class FetchingDataOptionsService {
  /**
   * 處理分頁選項
   *
   * @static
   * @param {Object} options
   * @returns {string}
   */
  static pagenate(options) {
    let pageNumber = options.pageNumber
    let pageSize = options.pageSize || DEFAULT_PAGE_SIZE

    if (pageNumber) {
      return `page[number]=${pageNumber}&page[size]=${pageSize}`
    } else {
      return ''
    }
  }

  /**
   * 處理排序選項
   *
   * @static
   * @param {Object} options
   * @returns {string}
   */
  static sort(options) {
    let sort = options.sort

    if (sort) {
      return `&sort=${sort}`
    } else {
      return ''
    }
  }

  /**
   * 處理 Filter 選項
   *
   * @static
   * @param {Object} options
   * @returns {string}
   */
  static filter(options) {
    let filter = options.filter

    if (filter) {
      return `&filter=${filter}`
    } else {
      return ''
    }
  }

  /**
   * 處理搜尋選項
   *
   * @static
   * @param {Object} options
   * @returns {string}
   */
  static search(options) {
    if (!options.search) {
      return ''
    } else {
      const keys = Object.keys(options.search)
      let result = ''

      keys.forEach(element => {
        if (options.search[element]) {
          result += `&q[${element}]=${options.search[element]}`
        }
      })

      return result
    }
  }
}
