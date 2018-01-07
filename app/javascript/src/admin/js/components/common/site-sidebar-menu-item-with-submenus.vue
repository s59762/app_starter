<template lang="pug">

li
  a.list-item-link(:href="menu.path")
    .icon
      i.fa(:class="menu.icon")
    span {{menu.title}}
  ul.submenu-list
    li(v-for="submenu in menu.submenus")
      a(:href="submenu.path") {{submenu.title}}

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

  // mounted() {},

  // methods: {}
}
</script>
