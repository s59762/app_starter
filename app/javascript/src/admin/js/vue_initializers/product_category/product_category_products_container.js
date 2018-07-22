import ProductCategory from '../../../../shared/resource_models/product_category.js'
import ProductsListTable from '../../components/product_category/products-list-table.vue'
import NewSubCategoryButton from '../../components/product_category/new-sub-category-button.vue'

export default {
  name: 'product-category-products-container',

  components: {
    ProductsListTable,
    NewSubCategoryButton
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
