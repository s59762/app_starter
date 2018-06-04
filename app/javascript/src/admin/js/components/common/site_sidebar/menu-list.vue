<template lang="pug">

.vc-common-site-sidebar-menu-list(v-if="hasMenus")
  p.menu-label {{title}}
  ul.common-site-sidebar-menu-list.menu-list
    div(:is="hasSubmenu(menu)"
        v-for="menu in menus"
        :menu="menu"
        @menu-hidden="tallyInvalidPolicyCount")

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
    title: {
      type: String,
      required: true
    },

    menus: {
      type: Array,
      required: true
    }
  },

  data() {
    return {
      invalidPolicyCount: 0
    }
  },

  computed: {
    hasMenus() {
      return this.invalidPolicyCount < this.menus.length
    }
  },

  methods: {
    hasSubmenu(menu) {
      if (menu.has_submenu) {
        return 'list-item-with-submenus'
      }
      return 'list-item'
    },

    tallyInvalidPolicyCount() {
      this.invalidPolicyCount += 1
    }
  }
}
</script>
