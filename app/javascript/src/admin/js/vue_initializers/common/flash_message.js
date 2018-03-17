import FlashMessage from '../../components/common/flash-message.vue'
import { mapGetters } from 'vuex'
import debounce from 'lodash.debounce'

export default {
  components: {
    FlashMessage
  },

  computed: {
    ...mapGetters(['flashMessages'])
  },

  beforeMount() {
    const body = document.body
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
    window.addEventListener('resize', debounce(handler, 200))
    handler()
  },

  mounted() {
    let messages = JSON.parse(this.$el.dataset.messages)
    this.$store.dispatch('setFlashMessages', messages)
  },

  methods: {
    toggleDevice(device) {
      this.$store.dispatch('toggleDevice', device)
    },

    toggleSidebar(option) {
      this.$store.dispatch('toggleSidebar', option)
    }
  }
}
