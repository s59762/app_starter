<template lang="pug">

.vc-product-option-value-new-button
  .button.is-small.is-primary(@click="showForm")
    .icon
      i.fa.fa-plus
    span {{ actionLocaleText('admin', 'add_product_option_value') }}
  b-modal(:active.sync="isFormActive")
    option-value-form(:option-type="optionType")

</template>

<script>
import OptionValueForm from './form.vue'

export default {
  components: {
    OptionValueForm
  },
  // mixins: [],
  props: {
    optionType: {
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
