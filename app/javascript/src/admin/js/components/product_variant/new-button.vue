<template lang="pug">

.vc-product-variant-new-button
  .add-option-type-button.button.is-default.is-block(@click="showForm")
    .icon
      i.fa.fa-plus
    span {{ actionLocaleText('admin', 'add_new', { model: modelNameLocaleText('product/variant') }) }}

  b-modal(:active.sync="isFormActive")
    variant-form(:product="product")

</template>

<script>
import VariantForm from './form.vue'

export default {
  components: {
    VariantForm
  },
  // mixins: [],
  props: {
    product: {
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
