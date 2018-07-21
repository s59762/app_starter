<template lang="pug">

.vc-product-option-types-columns
  .option-types-wrapper(v-if="optionTypes.length > 0")
    h4.section-title {{ pageTitleLocaleText('admin', 'products', 'option_type_fields') }}
    .option-type-fields(v-for="(optionType, typeIndex) in optionTypes"
                        :key="typeIndex")
      .counter {{typeIndex + 1}}
      .delete-button(@click="deleteOptionType(typeIndex)")
        i.fa.fa-close
      .columns
        .column
          b-field(:label="attributeLocaleText('product', 'option_name')"
                  :type="errors.errorClassAt('option_types')"
                  class="required")
            b-input(type="text"
                    v-model="optionType.name"
                    @input="errors.clear('option_types')"
                    placeholder="e.g. Color")
        .column
          .option-unit(v-for="(option, optionIndex) in optionType.options"
                        :key="optionIndex")
            b-field(:label="`${attributeLocaleText('product', 'option_value')} ${optionIndex + 1}`"
                    class="required")
              b-field(:type="errors.errorClassAt('option_types')")
                b-input(type="text"
                        v-model="option.value"
                        @input="errors.clear('option_types')"
                        placeholder="e.g. Black")
                p.control(v-if="optionType.options.length > 1")
                  button.button.is-danger(@click="deleteOptionFor(typeIndex, optionIndex)")
                    i.fa.fa-close
          .add-option-button.button.is-default.is-block(@click="addOptionFor(typeIndex)"
                                                data-behavior="product-add-option-button")
            .icon
              i.fa.fa-plus
            span {{actionLocaleText('admin', 'add_product_option_value')}}

  .has-text-danger(v-if="errors.has('option_types')")
        p.help {{ errors.get('option_types').join(', ') }}

  .add-option-type-button.button.is-default.is-block(@click="addOptionType"
                                                      data-behavior="product-add-option-type-button")
    .icon
      i.fa.fa-plus
    span {{actionLocaleText('admin', 'add_product_option_type')}}

  p.help {{ messageLocaleText('product_management.help_message.option_types') }}

</template>

<script>
const optionTypeTemplate = () => {
  return {
    name: '',
    options: [{ value: '' }]
  }
}

export default {
  // components: {},
  // mixins: [],
  props: {
    errors: {
      type: Object,
      required: true
    },

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
    addOptionType() {
      this.optionTypes.push(optionTypeTemplate())
    },

    deleteOptionType(index) {
      this.optionTypes.splice(index, 1)
    },

    addOptionFor(index) {
      this.optionTypes[index].options.push({ value: '' })
    },

    deleteOptionFor(typeIndex, optionIndex) {
      if (this.optionTypes[typeIndex].options.length < 2) return

      this.optionTypes[typeIndex].options.splice(optionIndex, 1)
    }
  }
}
</script>
