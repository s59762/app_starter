<template lang="pug">

div
  b-table(:data="users"
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

      b-table-column(field="email"
                    :label="attributeLocaleText('admin', 'email')"
                    sortable)
        | {{props.row.email}}

      b-table-column(field="created_at"
                    :label="attributeLocaleText('admin', 'created_at')"
                    sortable)
        | {{timeAgoLocaleText(props.row.created_at)}}

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
import backendPaginateAndFilterAndSortableMixin from '../mixins/backend_paginate_and_filter_and_sortable_mixin'

export default {
  // components: {},

  mixins: [backendPaginateAndFilterAndSortableMixin],

  // props: {},

  data() {
    return {
      isUsingCreatedHook: true,
      resourceType: 'users',
      currentUrlPath: '/admin/users',
      currentFilter: 0,
      availableFilters: ['']
    }
  },

  computed: {
    users() {
      return this.$store.getters['users/allResources']
    }
  }

  // created() {},

  // mounted() {},

  // methods: {}
}
</script>
