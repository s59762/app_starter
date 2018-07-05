<template lang="pug">

.vc-product-result-preview
  .info-section.basic-info
    .brand-name
      span.name {{ brandName }}
    .product-name
      span.name {{ productName }}
    .category-info
      .category-level.top
        span.name {{ topCategoryName }}
      .category-level.sub(v-if="subCategoryName")
        span.name {{ subCategoryName }}

  .info-section.cover-image
    .image-container(:class="{ 'is-empty': !coverImage }")
      img.image(v-if="coverImage"
                :src="coverImage")

  .info-section.options-info(v-if="optionTypes")
    label.label {{ attributeLocaleText('product', 'option_types') }}
    .option-unit(v-for="optionType in optionTypes"
                 v-if="optionType.name")
      .option-type
        span.name {{ optionType.name }}
      .option-value(v-for="option in optionType.options"
                    v-if="option.value")
        span.value {{ option.value }}

  .info-section.properties-info
    label.label {{ attributeLocaleText('product', 'properties') }}
    .property-unit
      .property-name
        span.name {{ attributeLocaleText('product', 'size') }}
      .property-value
        span.value {{ size || messageLocaleText('data_not_provided') }}
      .unit-name(v-if="size")
        span.name CM
    .property-unit
      .property-name
        span.name {{ attributeLocaleText('product', 'weight') }}
      .property-value
        span.value {{ weight || messageLocaleText('data_not_provided') }}
      .unit-name(v-if="weight")
        span.name KG
    .property-unit(v-for="property in properties")
      .property-name
        span.name {{ property.name }}
      .property-value
        span.value {{ property.value }}
      .unit-name(v-if="property.unit")
        span.name {{ property.unit }}

  hr

  .info-section.price-info
    .price-type.sell(v-if="SellPrice")
      span.price {{ SellPrice }}
    .price-type.discounted
      span.price {{ discountedPrice }}

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

    product: {
      type: Object,
      required: true
    }
  },
  // data() {
  //   return {}
  // },
  computed: {
    isNewRecord() {
      return this.product.isNewRecord()
    },

    brandName() {
      if (this.form.brand_id) return this.$store.getters['brands/find'](this.form.brand_id).name

      return '---'
    },

    productName() {
      if (this.form.name) return this.form.name

      return '---'
    },

    topCategoryName() {
      if (this.form.top_level_category_id)
        return this.$store.getters['productCategories/find'](this.form.top_level_category_id).name

      return '---'
    },

    subCategoryName() {
      if (this.form.sub_category_id)
        return this.$store.getters['productCategories/find'](this.form.sub_category_id).name
    },

    coverImage() {
      const images = this.$store.getters['productImages/all']
      const cover = images.filter(image => image.is_cover)[0]

      if (cover) return cover.url
      if (images.length > 0) return images[0].url
    },

    SellPrice() {
      if (this.form.price.sell && this.form.price.discounted) return this.form.price.sell
    },

    discountedPrice() {
      if (this.form.price.discounted) return this.form.price.discounted

      return this.form.price.sell
    },

    optionTypes() {
      if (this.isNewRecord) {
        if (this.form.option_types.length > 0) return this.form.option_types
      } else {
        const result = this.$store.getters['productOptionTypes/all'].map(type => {
          return {
            name: type.name,
            options: type.option_values.map(option => {
              return {
                value: this.$store.getters['productOptionValues/find'](option.id).value
              }
            })
          }
        })

        if (result.length > 0) return result
      }
    },

    properties() {
      if (this.form.properties.length > 0) return this.form.properties
    },

    size() {
      const properties = ['width', 'depth', 'height']
      let result = []

      properties.forEach(property => {
        if (this.form[property]) result.push(`${this.attributeLocaleText('product', property)} ${this.form[property]}`)
      })

      return result.join(' × ')
    },

    weight() {
      if (this.form.weight) return this.form.weight
    }
  }
  // created() {},
  // mounted() {},
  // methods: {}
}
</script>
