import FlashMessage from '../components/common/flash-message.vue'

export default {
  components: {
    FlashMessage
  },
  data: () => ({
    messages: JSON.parse(document.querySelector("[data-vue='flash_message']").dataset.messages)
  })
}
