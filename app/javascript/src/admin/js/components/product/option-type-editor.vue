<template lang="pug">

.vc-product-option-type-editor
  h4.section-title {{ pageTitleLocaleText('admin', 'products', 'option_type_fields') }}

  .option-type-unit(v-for="optionType in optionTypes")
    .option-type-name
      span.name {{ optionType.name }}
      option-type-edit-button(:option-type="optionType")

    .option-values
      .option-value-unit(v-for="optionValue in optionType.option_values"
                         :key="optionValue.id")
        .inner
          .value {{ fetchOptionValue(optionValue.id).value }}
          option-value-edit-button(:option-value="fetchOptionValue(optionValue.id)")

</template>

<script>
import OptionTypeEditButton from '../product_option_type/edit-button.vue'
import OptionValueEditButton from '../product_option_value/edit-button.vue'

export default {
  components: {
    OptionTypeEditButton,
    OptionValueEditButton
  },
  // mixins: [],
  props: {
    optionTypes: {
      type: Array,
      required: true
    }
  },
  // data() {
  //   return {}
  // },
  // computed: {},
  // created() {},
  // mounted() {},
  methods: {
    fetchOptionValue(id) {
      return this.$store.getters['productOptionValues/find'](id)
    }
  }
}
</script>
