<template lang="pug">

.vc-admin-list-table
  b-collapse.panel(:open.sync="isSearchOptionsOpen")
    .panel-heading(slot="trigger") {{actionLocaleText('admin', 'search_for', { model_name: modelNameLocaleText('admin') })}}
    .panel-block.is-multiline
      .column.is-12-mobile
        b-field
          b-input(type="text"
                  v-model="searchOptions.email_cont"
                  :placeholder="actionLocaleText('admin', 'search_by', { attribute_name: attributeLocaleText('admin', 'email') })"
                  icon="envelope")
      .column.is-12-mobile
        b-field
          b-input(type="text"
                  v-model="searchOptions.name_cont"
                  :placeholder="actionLocaleText('admin', 'search_by', { attribute_name: attributeLocaleText('admin', 'name') })"
                  icon="user")
      .column.is-narrow
        .button.is-default.is-block(@click="resetSearchOptions") {{actionLocaleText('admin', 'reset_search')}}
      .column.is-narrow
        .button.is-primary.is-block(@click="onSearchHandler") {{actionLocaleText('admin', 'search')}}

  section
    b-tabs(type="is-boxed"
           v-model="currentFilter"
           @change="filterOnChangeHandler")
      b-tab-item(label="活動中"
                 icon="check-circle")
      b-tab-item(label="已停權"
                 icon="ban")

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
          :hoverable="true"
          data-behavior="admin-list")

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

      b-table-column(:label="actionLocaleText('admin', 'options')"
                     numeric)
        suspend-button(:admin="props.row")
        | &nbsp;
        edit-button(:admin="props.row")


    template(slot='empty')
      section.section
        .content.has-text-grey.has-text-centered
          p
            b-icon(icon='times'
                  size='is-large')
          p {{messageLocaleText('there_is_no_data_for_now')}}

</template>

<script>
import SuspendButton from '../../components/admin/suspend-button'
import EditButton from '../../components/admin/edit-button'
import backendPaginateFilterSortAndSearchableMixin from '../mixins/backend_paginate_filter_sort_and_searchable_mixin'

export default {
  components: {
    SuspendButton,
    EditButton
  },

  mixins: [backendPaginateFilterSortAndSearchableMixin],

  // props: {},

  data() {
    return {
      resourceType: 'admins',
      currentFilter: 0,
      availableFilters: ['actived', 'suspended'],
      searchOptions: {
        email_cont: '',
        name_cont: ''
      }
    }
  },

  computed: {
    admins() {
      return this.$store.getters['admins/all']
    }
  },

  created() {
    this.fetchingInitialData()
  }

  // mounted() {},

  // methods: {}
}
</script>
