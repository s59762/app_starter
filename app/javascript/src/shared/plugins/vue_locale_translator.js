import i18n from 'i18n-js'
import moment from 'moment'

function install(Vue) {
  Vue.mixin({
    methods: {
      /**
       * 取得 Rails model attributes 的 i18n 值
       *
       * @param {string} model model name
       * @param {string} attribute attribute name
       * @returns {string}
       */
      attributeLocaleText(model, attribute, options = {}) {
        return i18n.t(`activerecord.attributes.${model}.${attribute}`, options)
      },

      /**
       * 取得 Rails model name 的 i18n 值
       *
       * @param {string} model model name
       * @param {boolean} isPlural 是否為複數（預設為 false）
       * @returns {string}
       */
      modelNameLocaleText(model, isPlural = false) {
        if (isPlural) {
          return i18n.t(`activerecord.models.${model}.others`)
        } else {
          return i18n.t(`activerecord.models.${model}.one`)
        }
      },

      /**
       * 取得 Rails model 中 enums 的 i18n 值
       *
       * @param {string} model model name
       * @param {string} enumAttribute enum 欄位的名稱
       * @param {string} key enum 值的名稱
       * @returns {string}
       */
      enumLocaleText(model, enumAttribute, key) {
        return i18n.t(`enums.${model}.${enumAttribute}.${key}`)
      },

      /**
       * 取得 Rails model 中 aasm state 的 i18n 值
       *
       * @param {string} model model name
       * @param {string} aasmAttribute 狀態的名稱
       * @param {string} state 狀態值的名稱
       * @returns {string}
       */
      aasmStateLocaleText(model, aasmAttribute, state) {
        return i18n.t(`aasm_state.${model}.${aasmAttribute}.${state}`)
      },

      /**
       * 取得 Rails model 中 public activity 的 i18n 值
       *
       * @param {string} model model name
       * @param {string} activity 活動的名稱
       * @param {Object} options 若需要可帶入 locals 物件
       * @returns {string}
       */
      activityLocaleText(model, activity, options = {}) {
        return i18n.t(`activity.${model}.${activity}`, options)
      },

      /**
       * 取得頁面標題的 i18n 值
       *
       * @param {string} scope 頁面操作角色（admin, client 等）
       * @param {string} pageName 頁面名稱
       * @param {string} subPageName 副頁面名稱
       * @returns {string}
       */
      pageTitleLocaleText(scope, pageName, subPageName) {
        return i18n.t(`page_titles.${scope}.${pageName}.${subPageName}`)
      },

      /**
       * 取得 action 的 i18n 值
       *
       * @param {string} scope 使用者角色
       * @param {string} action 動作的名稱
       * @returns {string}
       */
      actionLocaleText(scope, action, locals = {}) {
        return i18n.t(`actions.${scope}.${action}`, locals)
      },

      /**
       * 取得 TimeAgo 相對時間的 i18n 值
       *
       * @param {number} unixTime
       * @returns {string}
       */
      timeAgoLocaleText(unixTime) {
        return moment(unixTime, 'X').fromNow()
      },

      /**
       * 取得 message 的 i18n 值
       *
       * @param {string} message
       * @param {string} locals 可傳入變數
       * @returns {string}
       */
      messageLocaleText(message, locals = {}) {
        return i18n.t(`messages.${message}`, locals)
      }
    }
  })
}

export default install
