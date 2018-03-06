<template lang="pug">

.button.is-small.is-danger(v-if="!admin.is_suspended"
                           @click="suspendAdmin")
  span.icon
    i.fa.fa-ban
  span 停權

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
  // computed: {},
  // created() {},
  // mounted() {},
  methods: {
    suspendAdmin() {
      console.log(`${this.admin.name} ban!`)
    }
  }
}
</script>
