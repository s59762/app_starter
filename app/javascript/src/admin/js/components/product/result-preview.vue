<template lang="pug">

.vc-product-result-preview
  .info-section.basic-info
    .brand-name
      span.name WMM
    .product-name
      span.name 布面色塊獨立筒彈簧沙發
    .category-info
      .category-level.top
        span.name 生活用品
      .category-level.sub
        span.name 沙發

  .info-section.cover-image
    .image-container
      img.image

  .info-section.price-info
    .price-type.sell
      span.price 10000
    .price-type.discounted
      span.price 9280

  .info-section.options-info
    label.label {{ attributeLocaleText('product', 'option_types') }}
    .option-unit
      .option-type
        span.name 顏色
      .option-value
        span.value 紅
      .option-value
        span.value 白
    .option-unit
      .option-type
        span.name 尺寸
      .option-value
        span.value Ｓ
      .option-value
        span.value Ｌ

  .info-section.properties-info
    label.label {{ attributeLocaleText('product', 'properties') }}
    .property-unit
      .property-name
        span.name 電池容量
      .property-value
        span.value 12000
      .unit-name
        span.name mAh


</template>

<script>
export default {
  // components: {},
  // mixins: [],
  props: {
    form: {
      type: Object,
      required: true
    },

    isNewRecord: {
      type: Boolean,
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
