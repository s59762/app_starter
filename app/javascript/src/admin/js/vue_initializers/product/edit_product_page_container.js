import EditProductForm from '../../components/product/new-form.vue'

export default {
  name: 'edit-product-page-container',

  components: {
    EditProductForm
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
