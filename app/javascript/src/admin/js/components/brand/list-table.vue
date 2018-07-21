<template lang="pug">

.vc-brand-list-table
  b-table(:data="brands"
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

      b-table-column(field="brands.name"
                     :label="attributeLocaleText('brand', 'name')"
                     sortable)
        a(:href="brandPath(props.row)")
          .icon
            i.fa.fa-search
          span {{ props.row.name }}


      b-table-column(field="brands.products_count"
                     :label="attributeLocaleText('brand', 'products_count')"
                     sortable
                     numbric)
        | {{ props.row.products_count }}

      b-table-column.options(:label="actionLocaleText('admin', 'options')"
                             numeric)
        edit-brand-button(:brand="props.row")

    template(slot='empty')
      section.section
        .content.has-text-grey.has-text-centered
          p
            b-icon(icon='times'
                   size='is-large')
          p {{ messageLocaleText('there_is_no_data_for_now') }}

</template>

<script>
import EditBrandButton from './edit-button.vue'
import backendPaginateFilterSortAndSearchableMixin from '../mixins/backend_paginate_filter_sort_and_searchable_mixin'

export default {
  components: {
    EditBrandButton
  },

  mixins: [backendPaginateFilterSortAndSearchableMixin],
  // props: {},
  data() {
    return {
      resourceType: 'brands',
      sortField: 'brands.created_at'
    }
  },

  computed: {
    brands() {
      return this.$store.getters['brands/all']
    }
  },
  // created() {},
  mounted() {
    this.fetchingInitialData()
  },

  methods: {
    brandPath(brand) {
      return `/admin/brands/${brand.id}`
    }
  }
}
</script>
