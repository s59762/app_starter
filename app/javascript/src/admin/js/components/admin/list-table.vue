<template lang="pug">

b-table(:data="admins"
        paginated
        backend-pagination
        :currentPage="currentPage"
        :perPage="pageSize"
        @page-change="onPageChange"
        backend-sorting
        :default-sort="sortField"
        :default-sort-direction="sortOrder"
        @sort="onSort"
        :total="totalCount"
        :loading="isLoading"
        :hoverable="true")

  template(slot-scope="props")

    b-table-column(field="id"
                   label="ID"
                   sortable
                   numbric)
      | {{props.row.id}}

    b-table-column(field="name"
                   :label="attributeLocaleText('admin', 'name')")
      | {{props.row.name}}

    b-table-column(field="role"
                   :label="attributeLocaleText('admin', 'role')")
      | {{enumLocaleText('admin', 'role', props.row.role)}}

    b-table-column(field="created_at"
                   :label="attributeLocaleText('admin', 'created_at')"
                   sortable)
      | {{timeAgoLocalText(props.row.created_at)}}

    b-table-column(:label="actionLocaleText('admin', 'options')")


  template(slot='empty')
    section.section
      .content.has-text-grey.has-text-centered
        p
          b-icon(icon='times'
                 size='is-large')
        p 目前沒有資料

</template>

<script>
import queryString from 'query-string'

export default {
  // components: {},

  // mixins: [],

  // props: {},

  data() {
    return {
      currentPage: 1,
      pageSize: 25,
      sortOrder: 'desc',
      sortField: 'created_at'
    }
  },

  computed: {
    isLoading() {
      return this.$store.getters['admins/isLoading']
    },

    admins() {
      return this.$store.getters['admins/allResources']
    },

    totalCount() {
      return this.$store.getters['admins/metaInfo'].total_count
    },

    sortOrderValue() {
      if(this.sortOrder == 'desc') {
        return `-${this.sortField}`
      } else {
        return `${this.sortField}`
      }
    }
  },

  /*
   * 根據這到達此頁時的 URL QueryString 來決定如何送出 request 給 API。
   *
   * 在 `options` 變數的賦值過程中檢是否當前的 URL 有給自訂設定，若沒有則使用在 data
   * 中指定的預設值。接著透過 vuex action 取得 admins list，然後同樣透過 vuex action
   * 更新 queryString 的內容與 URL。
   *
   * 最後監聽 `window.onpopstate` 事件，若發生時（使用者按下瀏覽器的上一頁或下一頁）
   * 重新取得正確的資料，並更新 vuex store 中 queryString 為當前 URL 的內容。
   */
  created() {
    let options = this.checkCurrentQueryStringOptionsFromURL()

    this.fetchData(options)
    this.updateQueryString(options)

    window.onpopstate = event => {
      this.fetchData(event.state)
      this.$store.dispatch('updateQueryStringFromURL')
    }
  },

  // mounted() {},

  methods: {
    checkCurrentQueryStringOptionsFromURL() {
      let currentQueryString = queryString.parse(window.location.search)
      let options = {
        pageNumber: parseInt(currentQueryString['page[number]']) || this.currentPage,
        pageSize: parseInt(currentQueryString['page[size]']) || this.pageSize,
        sort: currentQueryString['sort'] || this.sortOrderValue
      }

      this.updateQueryOptions(options)

      return options
    },

    updateQueryOptions(options) {
      this.currentPage = options.pageNumber
      this.pageSize = options.pageSize

      if(options.sort.charAt(0) == '-') {
        this.sortOrder = 'desc'
        this.sortField = options.sort.slice(1)
      } else {
        this.sortOrder = 'asc'
        this.sortField = options.sort
      }
    },

    onPageChange(page) {
      let options = {
        pageNumber: page,
        pageSize: this.pageSize,
        sort: this.sortOrderValue
      }
      this.fetchData(options)
      this.updateQueryString(options)
    },

    onSort(field, order) {
      this.sortField = field
      this.sortOrder = order
      let options = {
        pageNumber: this.currentPage,
        pageSize: this.pageSize,
        sort: this.sortOrderValue
      }

      this.fetchData(options)
      this.updateQueryString(options)
    },

    fetchData(options) {
      this.currentPage = options.pageNumber
      this.$store.dispatch('admins/fetchAllResources', options)
    },

    updateQueryString(options) {
      this.$store.dispatch('updateQueryString', {
        options,
        newQueryString: `/admin/admins/?page[number]=${options.pageNumber}&page[size]=${options.pageSize}&sort=${options.sort}`
      })
    }
  }
}
</script>
