<template lang="pug">

.button.is-small(:class="buttonClass"
                 @click="confirm")
  span.icon
    i.fa(:class="buttonIcon")
  span {{buttonText}}

</template>

<script>
import ActionConfirmService from '../../../../shared/services/action_confirm_service'

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
        return ['notice', this.messageLocaleText('admin_is_suspended', { name: this.admin.name })]
      } else {
        return ['success', this.messageLocaleText('admin_is_unsuspended', { name: this.admin.name })]
      }
    },

    confirmationTitle() {
      if (this.admin.is_suspended) {
        return this.messageLocaleText('confirmations.you_will_unsuspend_this_admin')
      } else {
        return this.messageLocaleText('confirmations.you_will_suspend_this_admin')
      }
    }
  },
  // created() {},
  // mounted() {},
  methods: {
    confirm() {
      new ActionConfirmService({
        title: this.confirmationTitle
      }).confirm(this.suspendAdmin)
    },

    suspendAdmin() {
      this.$store.dispatch('admins/suspendResource', this.admin).then(() => {
        this.$store.dispatch('addFlashMessage', this.flashMessage)
      })
    }
  }
}
</script>
