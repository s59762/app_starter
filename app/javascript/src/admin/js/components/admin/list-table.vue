<template lang="pug">

div
  section
    b-tabs(v-model="currentFilter"
           @change="filterOnChangeHandler")
      b-tab-item(label="活動中")
      b-tab-item(label="已停權")

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
                    :label="attributeLocaleText('admin', 'name')"
                    sortable)
        | {{props.row.name}}

      b-table-column(field="role"
                    :label="attributeLocaleText('admin', 'role')"
                    sortable)
        | {{enumLocaleText('admin', 'role', props.row.role)}}

      b-table-column(field="created_at"
                    :label="attributeLocaleText('admin', 'created_at')"
                    sortable)
        | {{timeAgoLocaleText(props.row.created_at)}}

      b-table-column(:label="actionLocaleText('admin', 'options')")
        suspend-button(:admin="props.row")


    template(slot='empty')
      section.section
        .content.has-text-grey.has-text-centered
          p
            b-icon(icon='times'
                  size='is-large')
          p 目前沒有資料

</template>

<script>
import SuspendButton from '../../components/admin/suspend-button'
import backendPaginateAndFilterAndSortableMixin from '../mixins/backend_paginate_and_filter_and_sortable_mixin'

export default {
  components: {
    SuspendButton
  },

  mixins: [backendPaginateAndFilterAndSortableMixin],

  // props: {},

  data() {
    return {
      isUsingCreatedHook: true,
      resourceType: 'admins',
      currentUrlPath: '/admin/admins',
      currentFilter: 0,
      availableFilters: ['actived', 'suspended']
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
    }
  }

  // created() {},

  // mounted() {},

  // methods: {}
}
</script>
