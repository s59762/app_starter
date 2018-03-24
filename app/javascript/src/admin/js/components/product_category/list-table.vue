<template lang="pug">

.product-category-list-table

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
