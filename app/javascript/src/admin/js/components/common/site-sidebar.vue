<template lang="pug">

transition(enter-active-class="animated slideInLeft"
           leave-active-class="animated slideOutLeft")

  aside.common-site-sidebar.menu(v-show="sidebarIsOpen"
                                 :class="sidebarOpenedClass")

    template(v-for="item in menuItems")
      p.menu-label {{item.title}}
      menu-list(:menus="item.menus")

</template>

<script>
import MenuList from './site_sidebar/menu-list.vue'

export default {
  components: {
    MenuList
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
