<template lang="pug">

.product-new-form.box.content-box.is-primary
  .box-header.with-border
    h3.subtitle {{pageTitleLocaleText('admin', 'products', 'form')}}
  .box-body
    section.section.basic-info-wrapper
      b-field(:label="attributeLocaleText('product', 'name')"
              :type="errors.errorClassAt('name')"
              :message="errors.get('name')")
        b-input(type="text"
                placeholder="e.g. iMac Pro 3.8GHz"
                v-model="form.name"
                @input="errors.clear('name')")

      b-field(:label="attributeLocaleText('product', 'description')"
              :type="errors.errorClassAt('description')"
              :message="errors.get('description')")
        b-input(type="textarea"
                rows=8
                placeholder="e.g. A powerful tool for your professional works."
                v-model="form.description"
                @input="errors.clear('description')")

      .columns
        .column
          b-field(:label="attributeLocaleText('product', 'original_price')"
                  :type="errors.errorClassAt('price')"
                  :message="errors.get('price')")
            b-input(type="number"
                    placeholder="e.g. 80000"
                    v-model="form.price.original"
                    @input="errors.clear('price')")
        .column
          b-field(:label="attributeLocaleText('product', 'sell_price')"
                  :type="errors.errorClassAt('price')"
                  :message="errors.get('price')")
            b-input(type="number"
                    placeholder="e.g. 100000"
                    v-model="form.price.sell"
                    @input="errors.clear('price')")
        .column
          b-field(:label="attributeLocaleText('product', 'discounted_price')"
                  :type="errors.errorClassAt('price')"
                  :message="errors.get('price')")
            b-input(type="number"
                    placeholder="e.g. 98000"
                    v-model="form.price.discounted"
                    @input="errors.clear('price')")

      b-field(:label="attributeLocaleText('product', 'is_preorder')"
              :type="errors.errorClassAt('is_preorder')"
              :message="errors.get('is_preorder')")
        b-switch(v-model="form.is_preorder"
                 type="is-success"
                 @input="errors.clear('is_preorder')")
          | {{enumLocaleText('product', 'is_preorder', form.is_preorder)}}

    section.section.properties-wrapper
      h4.section-title {{pageTitleLocaleText('admin', 'products', 'property_fields')}}
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
                      placeholder="e.g. Weight"
                      v-model="property.name"
                      @input="errors.clear('properties')")
          .column.is-6
            b-field(:label="attributeLocaleText('product', 'property_value')"
                    :type="errors.errorClassAt('properties')"
                    :message="errors.get('properties')")
              b-input(type="text"
                      placeholder="e.g. 12"
                      v-model="property.value"
                      @input="errors.clear('properties')")
          .column
            b-field(:label="attributeLocaleText('product', 'property_unit')"
                    :type="errors.errorClassAt('properties')"
                    :message="errors.get('properties')")
              b-input(type="text"
                      placeholder="e.g. kg"
                      v-model="property.unit"
                      @input="errors.clear('properties')")

      .add-property-button.button.is-default.is-block(@click="addProperty")
        .icon
          i.fa.fa-plus
        span {{actionLocaleText('admin', 'add_product_property')}}

    br

    .is-pulled-right
      .button.is-primary(@click="submitForm") {{actionLocaleText('admin', 'submit')}}

</template>

<script>
import Product from '../../../../shared/resource_models/product'
import Form from '../../../../shared/forms/form_base'

const propertyTemplate = function() {
  return {
    name: '',
    value: '',
    unit: ''
  }
}

export default {
  // components: {},
  // mixins: [],
  // props: {},
  data() {
    return {
      form: new Form(new Product())
    }
  },

  computed: {
    errors() {
      return this.$store.getters['products/errors']
    }
  },

  created() {
    this.form.properties = [propertyTemplate()]
    this.form.price = {
      original: 0,
      sell: 0,
      discounted: 0
    }
  },

  // mounted() {},
  methods: {
    addProperty() {
      this.form.properties.push(propertyTemplate())
    },

    deleteProperty(index) {
      this.form.properties.splice(index, 1)
    },

    submitForm() {
      this.$store.dispatch('products/create', this.form.sync()).then(() => {
        Turbolinks.visit('/admin/products?product_added=1')
      })
    }
  }
}
</script>
