<template lang="pug">

.vc-product-variant-stock-management-unit
  .basic-info
    span.name(:data-master="attributeLocaleText('product/variant', 'is_master')") {{ variant.name }}
    span.sku {{ variant.sku }}

  .stock-info
    .columns
      .column.info-wrapper
        .info-unit
          .label {{ attributeLocaleText('product/variant', 'option_values') }}
          span.option-values(v-for="id in variant.option_value_ids")
            span.tag.is-default {{ fetchOptionTypeNameBy(fetchOptionValueBy(id).option_type_id) }}: {{ fetchOptionValueBy(id).value }}
      .column.info-wrapper
        .info-unit
          .label {{ attributeLocaleText('product/variant', 'stock') }}
          span.tag(:class="stockStatusClasses") {{ variant.stock }}

    .columns
      .column
        .button.is-danger.is-small.is-block
          .icon
            i.fa.fa-minus
          span 銷貨
      .column
        .button.is-success.is-small.is-block
          .icon
            i.fa.fa-plus
          span 進貨

</template>

<script>
import productVariantBasicMixin from '../mixins/product_variant/basic_mixin.js'

export default {
  // components: {},
  mixins: [productVariantBasicMixin],
  // props: {},
  // data() {
  //   return {}
  // },
  computed: {
    stockStatusClasses() {
      return {
        'is-success': true,
        'is-warning': this.variant.stock_status === 'low_stock',
        'is-danger': this.variant.stock_status === 'no_stock'
      }
    }
  }
  // created() {},
  // mounted() {},
  // methods: {}
}
</script>
