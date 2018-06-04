import SiteConfigForm from '../../components/site_config/form'

export default {
  name: 'site-config-container',

  components: {
    SiteConfigForm
  },

  // mixins: [],

  // props: {},

  // data() {
  //   return {}
  // },

  computed: {
    configs() {
      return this.$store.getters['siteConfigs/allConfigs']
    },

    isLoading() {
      return this.$store.getters['siteConfigs/isLoading']
    }
  },

  created() {
    this.$store.dispatch('siteConfigs/fetchConfigs')
  }

  // mounted() {},

  // methods: {}
}
