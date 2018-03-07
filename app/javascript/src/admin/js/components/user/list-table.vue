<template lang="pug">

div
  b-collapse.panel(:open.sync="searchOptionsIsOpen")
    .panel-heading(slot="trigger") {{actionLocaleText('admin', 'search_for', {model_name: modelNameLocaleText('user')})}}
    .panel-block
      .column.is-5
        b-field
          b-input(type="text"
                  v-model="searchOptions.email_cont"
                  placeholder="search with email"
                  icon="envelope")
      .column.is-5
        b-field
          b-input(type="text"
                  v-model="searchOptions.name_cont"
                  placeholder="search with name"
                  icon="user")
      .column.is-2
        .button.is-primary.is-block(@click="searchUser") {{actionLocaleText('admin', 'search')}}

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
import backendPaginateFilterSortAndSearchableMixin from '../mixins/backend_paginate_filter_sort_and_searchable_mixin'

export default {
  // components: {},

  mixins: [backendPaginateFilterSortAndSearchableMixin],

  // props: {},

  data() {
    return {
      isUsingCreatedHook: true,
      resourceType: 'users',
      currentUrlPath: '/admin/users',
      currentFilter: 0,
      availableFilters: [''],
      searchOptionsIsOpen: false,
      searchOptions: {
        email_cont: '',
        name_cont: ''
      }
    }
  },

  computed: {
    users() {
      return this.$store.getters['users/allResources']
    }
  },

  // created() {},

  // mounted() {},

  methods: {
    searchUser() {
      let options = {
        pageNumber: this.currentPage,
        pageSize: this.pageSize,
        sort: this.sortOrderValue,
        filter: this.availableFilters[this.currentFilter],
        search: this.searchOptions
      }

      this.fetchData(options)
      this.updateQueryString(options)
    }
  }
}
</script>
