<template lang="pug">

.vc-product-option-type-editor
  h4.section-title {{ pageTitleLocaleText('admin', 'products', 'option_type_fields') }}

  .option-type-unit(v-for="optionType in optionTypes")
    .option-type-name
      span.name {{ optionType.name }}
      span.button.is-small.is-info.edit-button
        .icon
          i.fa.fa-pencil

    .option-values
      .option-value-unit(v-for="optionValue in optionType.option_values"
                         :key="optionValue.id")
        .inner
          .value {{ fetchOptionValueContent(optionValue.id) }}

          span.button.is-info.edit-button
            .icon
              i.fa.fa-pencil

</template>

<script>
export default {
  // components: {},
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
    fetchOptionValueContent(id) {
      return this.$store.getters['productOptionValues/find'](id).value
    }
  }
}
</script>
