<template lang="pug">

span.vc-banner-delete-button.option-button
  longpress.button.is-small.is-danger(duration="2"
                                      :pressing-text="actionLocaleText('admin', 'long_press_for_action', { action: actionLocaleText('admin', 'delete') })"
                                      :action-text="actionLocaleText('admin', 'deleting')"
                                      :on-confirm="deleteBanner"
                                      data-behavior="delete-banner-button")
    .icon
      i.fa.fa-trash
    span {{actionLocaleText('admin', 'delete')}}

</template>

<script>
import Longpress from 'vue-longpress'

export default {
  components: {
    Longpress
  },
  // mixins: [],
  props: {
    banner: {
      type: Object,
      required: true
    }
  },
  // data() {
  //   return {}
  // },
  // computed: {},
  // created() {},
  // mounted() {},
  methods: {
    deleteBanner() {
      this.$store.dispatch('banners/destroy', this.banner).then(() => {
        return this.$store.dispatch('addFlashMessage', [
          'success',
          this.messageLocaleText('resource_deleted_successfully', { resource: this.modelNameLocaleText('banner') })
        ])
      })
    }
  }
}
</script>
