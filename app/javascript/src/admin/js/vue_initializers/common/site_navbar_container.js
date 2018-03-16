import SiteNavbar from '../../components/common/site-navbar.vue'

export default {
  components: {
    SiteNavbar
  },

  // mixins: {},

  // props: {},

  // data() {
  //   return {}
  // },

  // computed: {},

  // created() {},
  beforeMount() {
    const { body } = document
    const DISKTOP_WIDTH = 1024
    const RATIO = 3
    const handler = () => {
      if (!document.hidden) {
        let rect = body.getBoundingClientRect()
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
      this.$store.dispatch('toggleDevice', device)
    },

    toggleSidebar(option) {
      this.$store.dispatch('toggleSidebar', option)
    }
  }
}
