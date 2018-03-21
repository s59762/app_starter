<template lang="pug">

li.common-site-sidebar-list-item-with-submenus(v-if="isValidPolicy")
  a.list-item-link(@click="toggleSubmenu"
                   :class="activeClass")
    .icon
      i.fa(:class="menu.icon")
    span {{menu.title}}
    .submenu-active-indicator.icon.is-pulled-right(:class="submenuActiveClass")
      i.fa.fa-angle-right
  b-collapse(:open.sync="submenuActive")
    ul.submenu-list
      //- TODO: 這邊要拆成 component 才能獨立驗證 policy
      li(v-for="submenu in menu.submenus")
        a.submenu-list-link(:href="submenu.path")
          .icon(:class="submenuItemActiveItem(submenu)")
            i.fa.fa-circle
          span {{submenu.title}}

</template>

<script>
import listItemMixin from '../../mixins/site_sidebar/list_item_mixin'

export default {
  // components: {},

  mixins: [listItemMixin],

  // props: {},

  data() {
    return {
      submenuActive: false
    }
  },

  computed: {
    submenuActiveClass() {
      if (this.submenuActive) {
        return 'is-active'
      }
    }
  },

  // created() {},

  mounted() {
    this.submenuActive = this.isActive
  },

  methods: {
    toggleSubmenu() {
      this.submenuActive = !this.submenuActive
    },

    submenuItemActiveItem(submenu) {
      if (submenu.action == document.querySelector('body').className && this.submenuActive) {
        return 'is-active'
      }
    }
  }
}
</script>
