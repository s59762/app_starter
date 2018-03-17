<template lang="pug">

.dashboard-parts-section-box.box.content-box(:class="typeClass")
  .box-header.with-border(v-if="title")
    h2.box-title {{title}}

  slot

</template>

<script>
export default {
  // components: {},

  // mixins: [],

  props: {
    type: {
      type: String,
      default: 'default'
    },

    title: {
      type: String,
      default: ''
    }
  },

  // data() {
  //   return {}
  // },

  computed: {
    typeClass() {
      return `is-${this.type}`
    }
  }

  // created() {},

  // mounted() {},

  // methods: {}
}
</script>
