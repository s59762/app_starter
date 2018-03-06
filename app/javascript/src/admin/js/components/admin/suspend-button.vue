<template lang="pug">

.button.is-small(:class="buttonClass"
                 @click="suspendAdmin")
  span.icon
    i.fa(:class="buttonIcon")
  span {{buttonText}}

</template>

<script>
export default {
  // components: {},
  // mixins: [],
  props: {
    admin: {
      type: Object,
      required: true
    }
  },
  // data() {
  //   return {}
  // },
  computed: {
    buttonText() {
      if (this.admin.is_suspended) {
        return this.actionLocaleText('admin', 'unsuspend_admin')
      } else {
        return this.actionLocaleText('admin', 'suspend_admin')
      }
    },

    buttonClass() {
      if (this.admin.is_suspended) {
        return 'is-info'
      } else {
        return 'is-danger'
      }
    },

    buttonIcon() {
      if (this.admin.is_suspended) {
        return 'fa-check-circle'
      } else {
        return 'fa-ban'
      }
    },

    flashMessage() {
      if (this.admin.is_suspended) {
        return this.messageLocaleText('admin_is_suspended', { name: this.admin.name })
      } else {
        return this.messageLocaleText('admin_is_unsuspended', { name: this.admin.name })
      }
    }
  },
  // created() {},
  // mounted() {},
  methods: {
    suspendAdmin() {
      this.$store.dispatch('admins/suspendResource', this.admin.id).then(() => {
        this.$store.dispatch('addFlashMessage', ['success', this.flashMessage])
      })
    }
  }
}
</script>
