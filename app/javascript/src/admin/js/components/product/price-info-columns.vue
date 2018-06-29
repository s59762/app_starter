<template lang="pug">

section.vc-product-price-info-columns.section.price-info-wrapper
  .columns
    .column
      //- 成本
      b-field(:label="attributeLocaleText('product', 'original_price')"
              :type="errors.errorClassAt('price')")
        b-input(type="number"
                placeholder="e.g. 80000"
                v-model="price.original"
                data-behavior="product-original-price"
                @input="errors.clear('price')")
    .column
      //- 售價
      b-field(:label="attributeLocaleText('product', 'sell_price')"
              :type="errors.errorClassAt('price')"
              class="required")
        b-input(type="number"
                placeholder="e.g. 100000"
                v-model="price.sell"
                data-behavior="product-sell-price"
                @input="errors.clear('price')")
    .column
      //- 折扣價
      b-field(:label="attributeLocaleText('product', 'discounted_price')"
              :type="errors.errorClassAt('price')")
        b-input(type="number"
                placeholder="e.g. 98000"
                v-model="price.discounted"
                data-behavior="product-discounted-price"
                @input="errors.clear('price')")
  p.has-text-danger.help(v-if="errors.has('price')") {{errors.get('price')}}

</template>

<script>
export default {
  // components: {},
  // mixins: [],
  props: {
    errors: {
      type: Object,
      required: true
    },

    price: {
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
