import POLICIES from '../../../../../shared/policies'

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
    },

    isValidPolicy() {
      const policy = POLICIES[this.menu.policy] || null

      if (policy) {
        return this.validatePolicy(policy)
      } else {
        return true
      }
    }
  },

  methods: {
    validatePolicy(policy) {
      const currentUser = this.$store.getters['currentUser']
      const validateResult = new policy(currentUser)[this.menu.action]()

      if (!validateResult) {
        this.$emit('menu-hidden')
      }

      return validateResult
    }
  }
}
