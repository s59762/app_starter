<template lang="pug">

.vc-product-option-type-new-button
  .add-option-type-button.button.is-default.is-block(@click="showForm")
    .icon
      i.fa.fa-plus
    span {{ actionLocaleText('admin', 'add_product_option_type') }}

  b-modal(:active.sync="isFormActive"
          ref="modal")
    option-type-form(:product="product")
</template>

<script>
import OptionTypeForm from './form.vue'

export default {
  components: {
    OptionTypeForm
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
