<template lang="pug">

.vc-product-variant-editable-unit(:class="{ 'is-master': variant.is_master }")
  .basic-info
    span.name(:data-master="attributeLocaleText('product/variant', 'is_master')") {{ variant.name }}
    span.sku {{ variant.sku }}

  .columns
    .column.info-wrapper
      .info-unit
        .label {{  }}
      .info-unit
        .label {{ attributeLocaleText('product', 'original_price') }}
        span.price {{ variant.displayPrice('original') }}
      .info-unit
        .label {{ attributeLocaleText('product', 'sell_price') }}
        span.price {{ variant.displayPrice('sell') }}
      .info-unit
        .label {{ attributeLocaleText('product', 'discounted_price') }}
        span.price {{ variant.displayPrice('discounted') }}
    .column.info-wrapper
      .info-unit
        .label {{ attributeLocaleText('product', 'size') }}
        span.size {{ variant.displaySize() }}
      .info-unit
        .label {{ attributeLocaleText('product', 'weight') }}
        span.weight(v-if="variant.weight") {{ variant.weight }}（{{ attributeLocaleText('product', 'weight_unit') }}）
        span.weight(v-else) {{ messageLocaleText('data_not_provided') }}
      .info-unit
        .label {{ attributeLocaleText('product/variant', 'description') }}
        span.description {{ variant.description || 'none' }}
  .columns.info-wrapper
    .column
      set-as-master-button(:variant="variant"
                           size="is-small")
    .column
      edit-button(:variant="variant"
                  size="is-small")

</template>

<script>
import EditButton from './edit-button.vue'
import SetAsMasterButton from './set-as-master-button.vue'

export default {
  components: {
    EditButton,
    SetAsMasterButton
  },
  // mixins: [],
  props: {
    variant: {
      type: Object,
      required: true
    }
  }

  // data() {
  //   return {}
  // },
  // computed: {},
  // created() {},
  // mounted() {},
  // methods: {}
}
</script>
