<template lang="pug">

.vc-product-image-editable-unit
  .image-container
    img.image(:src="image.thumb_url")
    .edit-trigger(@click="showForm")
      .icon
        i.fa.fa-pencil
    .delete-button
      i.fa.fa-close

  b-modal(:active.sync="isFormActive")

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
  },

  data() {
    return {
      isFormActive: false
    }
  },
  // computed: {},
  // created() {},
  // mounted() {},
  methods: {
    showForm() {
      this.isFormActive = true
    }
  }
}
</script>
