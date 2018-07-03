export default {
  // components: {},

  props: {
    variant: {
      type: Object,
      required: true
    }
  },

  // data() {
  //   return {}
  // },

  // computed: {},

  methods: {
    fetchOptionTypeNameBy(id) {
      return this.$store.getters['productOptionTypes/find'](id).name
    },

    fetchOptionValueBy(id) {
      return this.$store.getters['productOptionValues/find'](id)
    }
  }
}
