<template lang="pug">

.product-list-table

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

  // computed: {},

  created() {
    this.fetchingInitialData()
  }

  // mounted() {},

  // methods: {}
}
</script>
