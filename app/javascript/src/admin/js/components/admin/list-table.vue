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
import backendPaginateAndSortable from '../mixins/backend_paginate_and_sortable_mixin'

export default {
  // components: {},

  mixins: [backendPaginateAndSortable],

  // props: {},

  // data() {
  //   return {}
  // },

  computed: {
    isLoading() {
      return this.$store.getters['admins/isLoading']
    },

    admins() {
      return this.$store.getters['admins/allResources']
    },

    totalCount() {
      return this.$store.getters['admins/metaInfo'].total_count
    }
  },

  // mounted() {},

  methods: {
    fetchData(options) {
      this.currentPage = options.pageNumber
      this.$store.dispatch('admins/fetchAllResources', options)
    },

    updateQueryString(options) {
      this.$store.dispatch('updateQueryString', {
        options,
        newQueryString: `/admin/admins/?page[number]=${options.pageNumber}&page[size]=${
          options.pageSize
        }&sort=${options.sort}`
      })
    }
  }
}
</script>
