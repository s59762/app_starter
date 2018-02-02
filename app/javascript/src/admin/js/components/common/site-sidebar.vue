<template lang="pug">

transition(enter-active-class="slideInLeft"
           leave-active-class="slideOutLeft")
  aside.menu.site-sidebar.animated(v-show="sidebarIsOpen"
                                   :class="sidebarOpenedClass")
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

  computed: {
    sidebarIsOpen() {
      return this.$store.getters['sidebarIsOpen']
    },

    sidebarOpenedClass() {
      if (this.sidebarIsOpen) {
        return 'is-active'
      }
    }
  },

  mounted() {
    this.menuItems = JSON.parse(this.$el.dataset.sidebarMenuItems)
  }
}
</script>
