<template lang="pug">

.vc-product-variant-edit-button
  .button.is-info.is-block(@click="showForm"
                           :class="size")
    .icon
      i.fa.fa-pencil
    span {{ actionLocaleText('admin', 'edit') }}
  b-modal(:active.sync="isFormActive")
    variant-form(:variant="variant")


</template>

<script>
import productVariantBasicMixin from '../mixins/product_variant/basic_mixin.js'
import VariantForm from './form.vue'

export default {
  components: {
    VariantForm
  },

  mixins: [productVariantBasicMixin],

  props: {
    size: {
      type: String,
      required: false
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
