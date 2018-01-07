<template lang="pug">

aside.menu.site-sidebar.animated.slideInLeft
  template(v-for="item in menuItems")
    p.menu-label
      | {{item.title}}
    sidebar-menu(:menus="item.menus")

</template>

<script>
import SidebarMenu from './site-sidebar-menu.vue'

export default {
  components: {
    SidebarMenu
  },

  data() {
    return {
      menuItems: {}
    }
  },

  mounted() {
    this.menuItems = JSON.parse(this.$el.dataset.sidebarMenuItems)
  }
}
</script>
