<template lang="pug">

.vc-product-variant-set-as-master-button
  .button.is-warning.is-block(v-if="!variant.is_master"
                              @click="setAsMaster"
                              :class="size")
    .icon
      i.fa.fa-check-circle
    span 設定為主規格

</template>

<script>
export default {
  // components: {},
  // mixins: [],
  props: {
    variant: {
      type: Object,
      required: true
    },

    size: {
      type: String,
      required: false
    }
  },
  // data() {
  //   return {}
  // },
  // computed: {},
  // created() {},
  // mounted() {},
  methods: {
    setAsMaster() {
      this.$store.dispatch('productVariants/setAsMaster', this.variant).then(() => {
        this.$store.dispatch('addFlashMessage', [
          'success',
          this.messageLocaleText('resource_updated_successfully', {
            resource: this.modelNameLocaleText('product/variant')
          })
        ])
      })
    }
  }
}
</script>
