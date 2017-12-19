<template lang="pug">

transition(leave-active-class="fadeOutUp")
  .alert.alert-dismissible.animated.fadeInDown(:class="mappingClasses" v-if="show")
    button.close(aria-hidden="true" type="button" @click="closeAlert") ×
    h4
      i.icon.fa(:class="mappingIcons")
    | {{message}}

</template>

<script>
const CLASSES_MAP = {
  success: 'alert-success',
  notice: 'alert-info',
  error: 'alert-danger'
}
const ICONS_MAP = {
  success: 'fa-thumbs-up',
  notice: 'fa-info-circle',
  error: 'fa-ban'
}

export default {
  props: ['messageType', 'message'],

  data: function() {
    return {
      show: true
    }
  },

  computed: {
    mappingClasses: function() {
      return CLASSES_MAP[this.messageType]
    },
    mappingIcons: function() {
      return ICONS_MAP[this.messageType]
    }
  },

  methods: {
    closeAlert: function() {
      this.show = false
    }
  },

  mounted: function() {
    setTimeout(
      function() {
        this.show = false
      }.bind(this),
      5000
    )
  }
}
</script>
