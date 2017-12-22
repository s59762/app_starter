<template lang="pug">
  transition(leave-active-class="bounceOutRight")
    .notification.animated.bounceInRight(:class="mappingClasses" v-if="show")
      button.delete(@click="closeAlert")
      | {{message}}
</template>

<script>
const CLASSES_MAP = {
  success: 'is-success',
  notice: 'is-info',
  error: 'is-danger'
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
