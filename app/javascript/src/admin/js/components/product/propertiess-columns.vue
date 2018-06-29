<template lang="pug">

.vc-product-propertiess-columns
  h4.section-title {{pageTitleLocaleText('admin', 'products', 'property_fields')}}

  .properties-wrapper
    //- 基本商品屬性（體積、重量）
    h5.sub-title {{pageTitleLocaleText('admin', 'products', 'basic_properties')}}
    .property-fields(v-for="basicProperty in basicProperties")
      .columns
        .column
          b-field(:label="attributeLocaleText('product', 'property_name')"
                  :type="errors.errorClassAt('properties')")
            b-input(type="text"
                    :value="attributeLocaleText('product', basicProperty.name)"
                    disabled)
        .column.is-6
          b-field(:label="attributeLocaleText('product', 'property_value')"
                  :type="errors.errorClassAt('properties')"
                  :message="errors.get(basicProperty.name)")
            b-input(type="number"
                    placeholder="e.g. 80"
                    v-model="form[basicProperty.name]"
                    data-behavior="product-width-value"
                    @input="errors.clear(basicProperty.name)")
        .column
          b-field(:label="attributeLocaleText('product', 'property_unit')"
                  :type="errors.errorClassAt('properties')")
            b-input(type="text"
                    :value="basicProperty.unit"
                    disabled)
    //- 自訂商品屬性
    h5.sub-title(v-if="form.properties.length > 0") {{pageTitleLocaleText('admin', 'products', 'extra_properties')}}
    .property-fields(v-for="(property, index) in form.properties")
      .property-count {{index + 1}}
      .delete-button(@click="deleteProperty(index)")
        i.fa.fa-close
      .columns
        .column
          b-field(:label="attributeLocaleText('product', 'property_name')"
                  :type="errors.errorClassAt('properties')"
                  :message="errors.get('properties')")
            b-input(type="text"
                    placeholder="e.g. Battery"
                    v-model="property.name"
                    data-behavior="product-property-name"
                    @input="errors.clear('properties')")
        .column.is-6
          b-field(:label="attributeLocaleText('product', 'property_value')"
                  :type="errors.errorClassAt('properties')"
                  :message="errors.get('properties')")
            b-input(type="text"
                    placeholder="e.g. 12000"
                    v-model="property.value"
                    data-behavior="product-property-value"
                    @input="errors.clear('properties')")
        .column
          b-field(:label="attributeLocaleText('product', 'property_unit')"
                  :type="errors.errorClassAt('properties')"
                  :message="errors.get('properties')")
            b-input(type="text"
                    placeholder="e.g. mAh"
                    v-model="property.unit"
                    data-behavior="product-property-unit"
                    @input="errors.clear('properties')")

  .add-property-button.button.is-default.is-block(@click="addProperty"
                                                  data-behavior="product-add-property-button")
    .icon
      i.fa.fa-plus
    span {{actionLocaleText('admin', 'add_product_property')}}

</template>

<script>
const propertyTemplate = () => {
  return {
    name: '',
    value: '',
    unit: ''
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

    form: {
      type: Object,
      required: true
    }
  },
  // data() {
  //   return {}
  // },
  computed: {
    basicProperties() {
      return [
        {
          name: 'width',
          unit: 'CM'
        },
        {
          name: 'depth',
          unit: 'CM'
        },
        {
          name: 'height',
          unit: 'CM'
        },
        {
          name: 'weight',
          unit: 'KG'
        }
      ]
    }
  },
  // created() {},
  // mounted() {},
  methods: {
    addProperty() {
      this.form.properties.push(propertyTemplate())
    },

    deleteProperty(index) {
      this.form.properties.splice(index, 1)
    }
  }
}
</script>
