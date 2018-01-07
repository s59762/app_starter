export default {
  // components: {},

  // mixins: {},

  // props: {},

  // data() {
  //   return {}
  // },

  // computed: {},

  // created() {},
  beforeMount() {
    const { body } = document
    const DISKTOP_WIDTH = 768
    const RATIO = 3
    const handler = () => {
      if (!document.hidden) {
        let rect = body.getBoundingClientRect()
        console.log(rect.width - RATIO)
        let isMobile = rect.width - RATIO < DISKTOP_WIDTH
        this.toggleDevice(isMobile ? 'mobile' : 'other')
        this.toggleSidebar(!isMobile)
      }
    }

    document.addEventListener('visibilitychange', handler)
    window.addEventListener('resize', handler)
    handler()
  },
  // mounted() {},

  methods: {
    toggleDevice(device) {
      console.log(device)
      this.$store.dispatch('toggleDevice', device)
    },

    toggleSidebar(option) {
      console.log(option)
      this.$store.dispatch('toggleSidebar', option)
    }
  }
}
