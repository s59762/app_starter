<template lang="pug">

li.vc-common-site-sidebar-list-item(v-if="isValidPolicy")
  a.list-item-link(:href="menu.path"
                   :class="activeClass")
    .icon
      i.fa(:class="menu.icon")
    span {{menu.title}}

</template>

<script>
import listItemMixin from '../../mixins/site_sidebar/list_item_mixin'

export default {
  // components: {},

  mixins: [listItemMixin]

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
