<template lang="pug">

.vc-product-image-set-as-cover-button(v-if="!image.is_cover")
  .button.is-warning(:class="size"
                     @click="setAsCover")
    .icon
      i.fa.fa-check-circle
    span {{ actionLocaleText('admin', 'set_as_cover') }}

</template>

<script>
export default {
  // components: {},
  // mixins: [],
  props: {
    image: {
      type: Object,
      required: true
    },

    size: {
      type: String,
      required: false,
      default: () => {
        return ''
      }
    }
  },
  // data() {
  //   return {}
  // },
  // computed: {},
  // created() {},
  // mounted() {},
  methods: {
    setAsCover() {
      console.log('opk')
    }
  }
}
</script>
