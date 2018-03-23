import ProductCategoryListTable from '../../components/product_category/list-table'
import NewProductCategoryButton from '../../components/product_category/new-button'
import backendPaginateFilterSortAndSearchableMixin from '../../components/mixins/backend_paginate_filter_sort_and_searchable_mixin'

export default {
  components: {
    ProductCategoryListTable,
    NewProductCategoryButton
  },

  mixins: [backendPaginateFilterSortAndSearchableMixin],

  // props: {},

  data() {
    return {}
  }

  // computed: {},

  // created() {},

  // mounted() {},

  // methods: {}
}
