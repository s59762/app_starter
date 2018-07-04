<template lang="pug">

.vc-product-image-editable-unit
  .image-container
    img.image(:src="image.thumb_url")
    .edit-trigger
      .icon
        i.fa.fa-pencil

</template>

<script>
export default {
  // components: {},
  // mixins: [],
  props: {
    image: {
      type: Object,
      required: true
    }
  }
  // data() {
  //   return {}
  // },
  // computed: {},
  // created() {},
  // mounted() {},
  // methods: {}
}
</script>
