<template lang="pug">

div
  b-collapse.panel(:open.sync="isSearchOptionsOpen")
    .panel-heading(slot="trigger"
                   data-behavior="search-user-panel") {{actionLocaleText('admin', 'search_for', { model_name: modelNameLocaleText('user') })}}
    .panel-block.is-multiline
      .column.is-12-mobile
        b-field
          b-input(type="text"
                  v-model="searchOptions.email_cont"
                  :placeholder="actionLocaleText('admin', 'search_by', { attribute_name: attributeLocaleText('user', 'email') })"
                  icon="envelope"
                  data-behavior="search-by-user-email-field")
      .column.is-12-mobile
        b-field
          b-input(type="text"
                  v-model="searchOptions.name_cont"
                  :placeholder="actionLocaleText('admin', 'search_by', { attribute_name: attributeLocaleText('user', 'name') })"
                  icon="user"
                  data-behavior="search-by-user-name-field")
      .column.is-narrow
        button.button.is-default.is-block(@click="resetSearchOptions"
                                          data-behavior="reset-search") {{actionLocaleText('admin', 'reset_search')}}
      .column.is-narrow
        button.button.is-primary.is-block(@click="onSearchHandler"
                                          data-behavior="search-button") {{actionLocaleText('admin', 'search')}}

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

      b-table-column(:label="actionLocaleText('admin', 'options')"
                     numeric)

    template(slot='empty')
      section.section
        .content.has-text-grey.has-text-centered
          p
            b-icon(icon='times'
                  size='is-large')
          p {{messageLocaleText('there_is_no_data_for_now')}}

</template>

<script>
import backendPaginateFilterSortAndSearchableMixin from '../mixins/backend_paginate_filter_sort_and_searchable_mixin'

export default {
  // components: {},

  mixins: [backendPaginateFilterSortAndSearchableMixin],

  // props: {},

  data() {
    return {
      resourceType: 'users',
      currentUrlPath: '/admin/users',
      currentFilter: 0,
      availableFilters: [''],
      searchOptions: {
        email_cont: '',
        name_cont: ''
      }
    }
  },

  computed: {
    users() {
      return this.$store.getters['users/all']
    }
  },

  created() {
    this.fetchingInitialData()
  }

  // mounted() {},

  // methods: {}
}
</script>
