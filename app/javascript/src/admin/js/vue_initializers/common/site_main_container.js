export default {
  // components: {},

  // mixins: {},

  // props: {},

  // data() {
  //   return {}
  // },

  computed: {
    sidebarIsOpen() {
      return this.$store.getters['sidebarIsOpen']
    },

    sidebarOpenedClass() {
      if (this.sidebarIsOpen) {
        return 'sidebar-is-opened'
      }
    }
  },

  // created() {},
  beforeMount() {
    const { body } = document
    const DISKTOP_WIDTH = 768
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
