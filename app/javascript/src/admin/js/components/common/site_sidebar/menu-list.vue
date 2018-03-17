<template lang="pug">

ul.common-site-sidebar-menu-list.menu-list
  div(:is="hasSubmenu(menu)"
      v-for="menu in menus"
      :menu="menu")

</template>

<script>
import ListItem from './list-item.vue'
import ListItemWithSubmenus from './list-item-with-submenus.vue'

export default {
  components: {
    ListItem,
    ListItemWithSubmenus
  },

  props: {
    menus: {
      type: Array,
      required: true
    }
  },

  methods: {
    hasSubmenu(menu) {
      if (menu.has_submenu) {
        return 'list-item-with-submenus'
      }
      return 'list-item'
    }
  }
}
</script>
