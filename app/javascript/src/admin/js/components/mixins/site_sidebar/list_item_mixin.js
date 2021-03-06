import POLICIES from '../../../../../shared/policies'

export default {
  // components: {},

  props: {
    menu: {
      type: Object,
      required: true
    }
  },

  data() {
    return {
      isHidden: false
    }
  },

  computed: {
    isActive() {
      const activeIndentity = `/${window.location.pathname
        .split('/')
        .slice(1, 3)
        .join('/')}`

      return activeIndentity == this.menu.active_by
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

      if (!validateResult && !this.isHidden) {
        this.isHidden = true
        this.$emit('menu-hidden', this.menu)
      }

      return validateResult
    }
  }
}
