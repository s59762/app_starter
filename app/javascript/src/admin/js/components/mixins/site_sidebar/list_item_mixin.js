export default {
  // components: {},

  props: {
    menu: {
      type: Object,
      required: true
    }
  },

  // data() {
  //   return {}
  // },

  computed: {
    isActive() {
      return window.location.pathname == this.menu.active_by
    },

    activeClass() {
      if (this.isActive) {
        return 'is-active'
      }
    }
  }

  // methods: {}
}
