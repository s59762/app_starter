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
          span.tag.is-large(:class="stockStatusClasses") {{ variant.stock }}

    .columns
      .column
        update-stock-button(:variant="variant"
                            action="decrease")
      .column
        update-stock-button(:variant="variant"
                            action="increase")

</template>

<script>
import productVariantBasicMixin from '../mixins/product_variant/basic_mixin.js'
import UpdateStockButton from './update-stock-button.vue'

export default {
  components: {
    UpdateStockButton
  },

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
