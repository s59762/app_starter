<template lang="pug">

.vc-product-option-type-editor
  h4.section-title {{ pageTitleLocaleText('admin', 'products', 'option_type_fields') }}

  .option-type-unit(v-for="optionType in optionTypes")
    .option-type-name
      span.name {{ optionType.name }}
      option-type-edit-button(:option-type="optionType")

      option-value-new-button(:option-type-id="optionType.id")

    .option-values
      .option-value-unit(v-for="optionValue in relatedOptionValuesOf(optionType)"
                         :key="optionValue.id")
        .inner
          .value {{ optionValue.value }}
          option-value-edit-button(:option-value="optionValue")

</template>

<script>
import OptionTypeEditButton from '../product_option_type/edit-button.vue'
import OptionValueEditButton from '../product_option_value/edit-button.vue'
import OptionValueNewButton from '../product_option_value/new-button.vue'

export default {
  components: {
    OptionTypeEditButton,
    OptionValueEditButton,
    OptionValueNewButton
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
    relatedOptionValuesOf(optionType) {
      return this.$store.getters['productOptionValues/all'].filter(
        value => String(value.option_type_id) === optionType.id
      )
    }
  }
}
</script>
