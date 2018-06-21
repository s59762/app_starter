import ProductForm from '../../components/product/form'

export default {
  name: 'edit-product-page-container',

  components: {
    ProductForm
  },

  // mixins: [],

  // props: {},

  data() {
    return {
      productId: null
    }
  },

  computed: {
    product() {
      return this.$store.getters['products/find'](this.productId)
    },

    isReady() {
      return typeof this.product.id === 'string'
    }
  },

  // created() {},

  mounted() {
    this.productId = this.$el.dataset.product

    this.$store.dispatch('products/find', this.productId)
  },

  // methods: {}
}
