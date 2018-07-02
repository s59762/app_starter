<template lang="pug">

.vc-product-variant-editable-unit(:class="{ 'is-master': variant.is_master }")
  .basic-info
    span.name(:data-master="attributeLocaleText('product/variant', 'is_master')") {{ variant.name }}
    span.sku {{ variant.sku }}

  .columns
    .column.info-wrapper
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
        span.price {{ variant.displaySize() }}
      .info-unit
        .label {{ attributeLocaleText('product', 'weight') }}
        span.price {{ variant.weight }}（{{ attributeLocaleText('product', 'weight_unit') }}）
      .info-unit
        .label {{ attributeLocaleText('product/variant', 'description') }}
        span.price {{ variant.description || 'none' }}
  .columns
    .column
      edit-button(:variant="variant"
                  size="is-small")
    .column
      .button.is-warning.is-block.is-small(v-if="!variant.is_master"
                                           @click="setAsMaster")
        .icon
          i.fa.fa-check-circle-o
        span 設定為主規格

</template>

<script>
import EditButton from './edit-button.vue'

export default {
  components: {
    EditButton
  },
  // mixins: [],
  props: {
    variant: {
      type: Object,
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
    setAsMaster() {
      this.$store.dispatch('productVariants/setAsMaster', this.variant).then(() => {
        this.$store.dispatch('addFlashMessage', [
          'success',
          this.messageLocaleText('resource_updated_successfully', {
            resource: this.modelNameLocaleText('product/variant')
          })
        ])
      })
    }
  }
}
</script>
