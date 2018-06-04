<template lang="pug">

nav.vc-common-site-navbar.navbar.is-fixed-top.level.animated
  .nav-left
    .sidebar-toggle(@click="toggleSidebar")
      i.fa.fa-bars
  .nav-center
    .brand-logo
      span
        b App
        | Starter
  .nav-right
    .options-btn.dropdown.is-right.is-hoverable(:class="optionMenuActive")
      .dropdown-trigger(@click="triggerOptionMenu")
        button.button(aria-haspopup='true', aria-controls='dropdown-menu')
          span.icon.is-small
            i.fa.fa-gear(aria-hidden='true')
      .dropdown-menu(role='menu')
        .dropdown-content
          a.dropdown-item(href='#')
            span.icon
              i.fa.fa-pencil-square-o
            span Edit Profile
          hr.dropdown-divider
          a.dropdown-item(:href="logoutPath"
                          data-method="delete")
            span.icon
              i.fa.fa-sign-out
            span Log out

</template>

<script>
export default {
  // components: {},

  // mixins: {},

  props: {
    logoutPath: {
      type: String,
      required: true
    }
  },

  data() {
    return {
      isOptionMenuOpen: false
    }
  },

  computed: {
    optionMenuActive() {
      if (this.isOptionMenuOpen == true) {
        return 'is-active'
      }
    },

    sidebarIsOpen() {
      return this.$store.getters['sidebarIsOpen']
    }
  },

  // created() {},

  // mounted() {},

  methods: {
    triggerOptionMenu() {
      this.isOptionMenuOpen = !this.isOptionMenuOpen
    },

    toggleSidebar() {
      this.$store.dispatch('toggleSidebar', !this.sidebarIsOpen)
    }
  }
}
</script>
