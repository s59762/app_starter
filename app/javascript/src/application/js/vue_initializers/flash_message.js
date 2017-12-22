import FlashMessage from '../components/common/flash-message.vue'
import { mapGetters } from 'vuex'

export default {
  components: {
    FlashMessage
  },

  computed: {
    ...mapGetters(['flashMessages'])
  },

  created() {
    let messages = JSON.parse(document.querySelector("[data-vue='flash_message']").dataset.messages)
    this.$store.dispatch('setFlashMessages', messages)
  }
}
