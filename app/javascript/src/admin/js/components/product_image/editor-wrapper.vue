<template lang="pug">

.vc-product-image-editor-wrapper
  .image-list-wrapper
    .general-image-list.image-category
      h4.title {{ attributeLocaleText('product/image', 'general_images') }}
      .image-list
        image-editable-unit(v-for="image in generalImages"
                            :image="image"
                            :key="image.id")
        new-image-button(:product="product")

    .variant-image-list.image-category(v-for="variant in variants"
                                       :key="variant.id")
      h4.title {{ attributeLocaleText('product/image', 'images_for', { variant_name: `${variant.name} - ${variant.sku}` }) }}
      .image-list
        image-editable-unit(v-for="image in imagesFor(variant)"
                            :image="image"
                            :key="image.id")
        new-image-button(:product="product"
                         :variant="variant")


</template>

<script>
import ImageEditableUnit from '../product_image/editable-unit.vue'
import NewImageButton from './new-button.vue'

export default {
  components: {
    ImageEditableUnit,
    NewImageButton
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
