<template lang="pug">

li
  a.list-item-link(:href="menu.path"
                   :class="activeClass")
    .icon
      i.fa(:class="menu.icon")
    span {{menu.title}}

</template>

<script>
import siteSidebarMenuItemMixin from '../mixins/site_sidebar_menu_item_mixin'

export default {
  // components: {},

  mixins: [siteSidebarMenuItemMixin],

  // props: {},

  // data() {
  //   return {}
  // },

  // computed: {},

  // created() {},

  // mounted() {},

  // methods: {}
}
</script>
