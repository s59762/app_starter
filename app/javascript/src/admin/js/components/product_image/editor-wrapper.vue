<template lang="pug">

.vc-product-image-editor-wrapper
  .tools-wrapper
    .is-pulled-right
      .upload-images-button.button.is-primary
        .icon
          i.fa.fa-plus
        span 新增商品圖片

  .image-list-wrapper
    .general-image-list.image-category
      h4.title {{ attributeLocaleText('product/image', 'general_images') }}
      .image-list
        template(v-if="generalImages.length > 0")
          image-editable-unit(v-for="image in generalImages"
                              :image="image"
                              :key="image.id")
        template(v-else)
          .empty-state
            .inner
              i.fa.fa-meh-o
      .image-list

    .variant-image-list.image-category(v-for="variant in variants"
                                       :key="variant.id")
      h4.title {{ attributeLocaleText('product/image', 'images_for', { variant_name: `${variant.name} - ${variant.sku}` }) }}
      .image-list
        template(v-if="imagesFor(variant)")
          image-editable-unit(v-for="image in imagesFor(variant)"
                              :image="image"
                              :key="image.id")
        template(v-else)
          .empty-state
            .inner
              i.fa.fa-meh-o


</template>

<script>
import ImageEditableUnit from '../product_image/editable-unit.vue'

export default {
  components: {
    ImageEditableUnit
  },
  // mixins: [],
  props: {
    product: {
      type: Object,
      required: true
    }
  },
  // data() {
  //   return {}
  // },
  computed: {
    images() {
      return this.$store.getters['productImages/all'].filter(image => image.product_id === parseInt(this.product.id))
    },

    variants() {
      return this.$store.getters['productVariants/all'].filter(
        variant => variant.product_id === parseInt(this.product.id)
      )
    },

    generalImages() {
      return this.images.filter(image => image.variant_id === null)
    }
  },
  // created() {},
  // mounted() {},
  methods: {
    imagesFor(variant) {
      const images = this.images.filter(image => image.variant_id === parseInt(variant.id))

      if (images.length === 0) return null

      return images
    }
  }
}
</script>
