<template lang="pug">

.product-list-table
  b-table(:data="projects"
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
                     :label="attributeLocaleText('product', 'name')"
                     sortable)
        | {{props.row.name}}

      b-table-column(field="original_price"
                     :label="attributeLocaleText('product', 'original_price')"
                     sortable
                     numbric)
        | {{props.row.original_price}}

      b-table-column(field="sell_price"
                     :label="attributeLocaleText('product', 'sell_price')"
                     sortable
                     numbric)
        | {{props.row.sell_price}}

      b-table-column(field="discounted_price"
                     :label="attributeLocaleText('product', 'discounted_price')"
                     sortable
                     numbric)
        | {{props.row.discounted_price}}

      b-table-column(field="is_preorder"
                     :label="attributeLocaleText('product', 'is_preorder')"
                     sortable
                     numbric)
        | {{props.row.is_preorder}}

      b-table-column(:label="actionLocaleText('admin', 'options')"
                    numeric)
          button.button.is-small.is-default 目前沒有功能

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
      resourceType: 'products',
      currentUrlPath: '/admin/products',
      availableFilters: ['']
    }
  },

  computed: {
    projects() {
      return this.$store.getters['products/allResources']
    }
  },

  created() {
    this.fetchingInitialData()
  }

  // mounted() {},

  // methods: {}
}
</script>
