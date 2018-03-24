<template lang="pug">

.product-category-list-table
  b-table(:data="rootCategories"
          paginated
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
                    numbric
                    width="50")
        | {{props.row.id}}

      b-table-column(field="name"
                    :label="attributeLocaleText('product_category', 'name')"
                    sortable)
        | {{props.row.name}}

      b-table-column(:label="actionLocaleText('admin', 'options')")

    template(slot='empty')
      section.section
        .content.has-text-grey.has-text-centered
          p
            b-icon(icon='times'
                  size='is-large')
          p {{messageLocaleText('there_is_no_data_for_now')}}

</template>

<script>
import backendPaginateFilterSortAndSearchableMixin from '../../components/mixins/backend_paginate_filter_sort_and_searchable_mixin'

export default {
  // components: {},

  mixins: [backendPaginateFilterSortAndSearchableMixin],

  // props: {},

  data() {
    return {
      resourceType: 'productCategories',
      currentUrlPath: '/admin/product_categories',
      currentPage: null,
      pageSize: null,
      sortOrder: 'asc',
      sortField: 'id',
      availableFilters: ['']
    }
  },

  computed: {
    categories() {
      return this.$store.getters['productCategories/allResources']
    },

    // 最上層的 ProductCategory
    rootCategories() {
      return this.categories.filter(element => Object.keys(element.parent).length === 0)
    },

    secondLevelCategories() {
      return this.findNextLevelCategoriesFor(this.rootCategories)
    },

    thirdLevelCategories() {
      return this.findNextLevelCategoriesFor(this.secondLevelCategories)
    }
  },

  // created() {},

  mounted() {
    this.fetchingInitialData()
  },

  methods: {
    findNextLevelCategoriesFor(parents) {
      let nextLevelCategoriesID = []
      let result = []

      parents.forEach(parent => {
        parent.sub_categories.forEach(element => {
          nextLevelCategoriesID.push(element.id)
        })
      })

      nextLevelCategoriesID.forEach(id => {
        result.push(this.categories.find(element => element.id == id))
      })

      return result
    }
  }
}
</script>
