<template lang="pug">

li
  a.list-item-link(:href="menu.path")
    .icon
      i.fa(:class="menu.icon")
    span {{menu.title}}

</template>

<script>
export default {
  // components: {},

  // mixins: {},

  props: {
    menu: {
      type: Object,
      required: true
    }
  },

  // data() {
  //   return {}
  // },

  // computed: {},

  // created() {},

  mounted() {
    console.log(window.location.pathname)
  },

  // methods: {}
}
</script>
