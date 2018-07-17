import ProductCategoryListTable from '../../components/product_category/list-table'
import NewProductCategoryButton from '../../components/product_category/new-button'
import backendPaginateFilterSortAndSearchableMixin from '../../components/mixins/backend_paginate_filter_sort_and_searchable_mixin'

export default {
  name: 'product-category-list-container',

  components: {
    ProductCategoryListTable,
    NewProductCategoryButton
  },

  mixins: [backendPaginateFilterSortAndSearchableMixin],

  // props: {},

  data() {
    return {
      resourceType: 'productCategories',
      currentPage: null,
      pageSize: null,
      sortOrder: 'asc',
      sortField: 'id',
      availableFilters: ['']
    }
  },

  // computed: {},

  // created() {},

  // mounted() {},

  methods: {
    categoryAddedHandler() {
      const options = this.checkCurrentQueryStringOptionsFromURL()

      this.fetchData(options)
    }
  }
}
