import FlashMessage from '../../components/common/flash-message.vue'
import {
  mapGetters
} from 'vuex'
import debounce from 'lodash.debounce'

export default {
  name: 'basic-initializer',

  components: {
    FlashMessage
  },

  computed: {
    ...mapGetters(['flashMessages', 'currentUser'])
  },

  beforeMount() {
    const body = document.body
    const IPHONE_SE_WIDTH = 320
    const IPHONE_PLUS_WIDTH = 414
    const IPAD_PRO_WIDTH = 1024
    const LEEWAY = 1
    const handler = () => {
      if (!document.hidden) {
        let rect = body.getBoundingClientRect()
        let isMobile = rect.width < IPAD_PRO_WIDTH + LEEWAY
        let deviceType = ''

        if (isMobile && rect.width > IPHONE_SE_WIDTH) {
          deviceType = rect.width > IPHONE_PLUS_WIDTH ? 'tablet' : 'iphone'
        } else {
          deviceType = isMobile ? 'iphone-se' : 'desktop'
        }

        this.toggleDevice({
          isMobile,
          deviceType
        })
        this.toggleSidebar(!isMobile)
      }
    }

    window.addEventListener('resize', debounce(handler, 200))
    handler()
  },

  mounted() {
    const flashMessages = JSON.parse(this.$el.dataset.flashMessages)

    this.$store.dispatch('setFlashMessages', flashMessages)
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
