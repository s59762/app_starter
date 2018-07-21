import NewBrandBannerButton from '../../components/brand_banner/new-button.vue'
import EditButton from '../../components/brand/edit-button.vue'
import ProductList from '../../components/brand/product-list.vue'
import BannerList from '../../components/brand/banner-list.vue'

export default {
  name: 'brand-show-container',

  components: {
    NewBrandBannerButton,
    EditButton,
    ProductList,
    BannerList
  },

  // mixins: [],

  // props: {},

  data() {
    return {
      brandId: null,
      currentTab: 0
    }
  },

  computed: {
    brand() {
      return this.$store.getters['brands/find'](this.brandId)
    },

    brandLoaded() {
      return typeof this.brand.id === 'string'
    }
  },

  // created() {},

  mounted() {
    this.brandId = this.$el.dataset.brand
    this.$store.dispatch('brands/find', this.brandId)
  },

  // methods: {}
}
