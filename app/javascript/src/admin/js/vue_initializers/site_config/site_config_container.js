export default {
  // components: {},

  // mixins: [],

  // props: {},

  // data() {
  //   return {}
  // },

  computed: {
    configs() {
      return this.$store.getters['siteConfigs/allConfigs']
    }
  },

  created() {
    this.$store.dispatch('siteConfigs/fetchConfigs')
  }

  // mounted() {},

  // methods: {}
}
