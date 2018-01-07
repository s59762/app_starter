<template lang="pug">

ul.menu-list
  div(:is="hasSubmenu(menu)"
      v-for="menu in menus"
      :menu="menu")

</template>

<script>
import SidebarMenuItem from './site-sidebar-menu-item.vue'
import SidebarMenuItemWithSubmenus from './site-sidebar-menu-item-with-submenus.vue'

export default {
  components: {
    SidebarMenuItem,
    SidebarMenuItemWithSubmenus
  },

  props: {
    menus: {
      type: Array,
      required: true
    }
  },

  methods: {
    hasSubmenu(menu) {
      if (menu.has_submenu) { return 'sidebar-menu-item-with-submenus'}
      return 'sidebar-menu-item'
    }
  }
}
</script>
