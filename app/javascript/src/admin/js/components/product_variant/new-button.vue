<template lang="pug">

.vc-product-variant-new-button
  .add-option-type-button.button.is-default.is-block(@click="showForm")
    .icon
      i.fa.fa-plus
    span {{actionLocaleText('admin', 'add_new', { model: modelNameLocaleText('product/variant') })}}

  b-modal(:active.sync="isFormActive")
    variant-form(:variant="variant")

</template>

<script>
import VariantForm from './form.vue'
import ProductVariant from '../../../../shared/resource_models/product_variant.js'

export default {
  components: {
    VariantForm
  },
  // mixins: [],
  props: {
    productId: {
      type: String,
      required: true
    }
  },
  data() {
    return {
      variant: new ProductVariant({ product_id: this.productId }),
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
