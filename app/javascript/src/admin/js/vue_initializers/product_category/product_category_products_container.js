import ProductCategory from '../../../../shared/resource_models/product_category.js'
import ProductsListTable from '../../components/product_category/products-list-table.vue'

export default {
  name: 'product-category-products-container',

  components: {
    ProductsListTable
  },

  // mixins: [],

  // props: {},

  data() {
    return {
      productCategory: null
    }
  },

  computed: {
    isReady() {
      return this.productCategory && typeof this.productCategory.id === 'string'
    }
  },

  // created() {},

  mounted() {
    this.productCategory = new ProductCategory({
      id: this.$el.dataset.productCategory
    })
  },

  // methods: {}
}
