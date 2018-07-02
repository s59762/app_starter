<template lang="pug">

.vc-product-variant-form.box.form-container-box.is-default.clearfix
  h3.subtitle {{ pageTitleLocaleText('admin', 'products', 'edit_variant') }}

  section.section
    .columns
      .column
        b-field(:label="attributeLocaleText('product/variant', 'name')"
                :type="errors.errorClassAt('name')"
                :message="errors.get('name')")
          b-input(type="text"
                  placeholder="e.g. Fashion Silver"
                  v-model="form.name"
                  @input="errors.clear('name')")
      .column
        b-field(:label="attributeLocaleText('product/variant', 'sku')"
                :type="errors.errorClassAt('sku')"
                :message="errors.get('sku')")
          b-input(type="text"
                  placeholder="e.g. A001839-FS"
                  v-model="form.sku"
                  @input="errors.clear('sku')")

  section.section
    price-info-columns(:price="form.price"
                       :errors="errors")

  section.section
    properties-columns(:form="form"
                       :errors="errors")

    b-field(:label="attributeLocaleText('product/variant', 'description')"
            :type="errors.errorClassAt('description')"
            :message="errors.get('description')")
      b-input(type="textarea"
              v-model="form.description"
              @input="errors.clear('description')")

  br

  .is-pulled-right
    .button.is-primary(@click="submitForm"
                       :class="{'is-loading': isLoading}") {{ actionLocaleText('admin', 'submit') }}

</template>

<script>
import Form from 'odd-form_object'
import ProductVariant from '../../../../shared/resource_models/product_variant.js'
import PriceInfoColumns from '../product/price-info-columns.vue'
import PropertiesColumns from '../product/properties-columns.vue'

export default {
  components: {
    PriceInfoColumns,
    PropertiesColumns
  },
  // mixins: [],
  props: {
    variant: {
      type: Object,
      required: false,
      default: () => {
        new ProductVariant()
      }
    }
  },

  data() {
    return {
      form: new Form(this.variant)
    }
  },

  computed: {
    isLoading() {
      return this.$store.getters['productVariants/isLoading']
    },

    errors() {
      return this.variant.errors
    }
  },

  created() {
    if (this.variant.isNewRecord()) {
      this.form.price = {
        original: 0,
        sell: 0,
        discounted: 0
      }
    } else {
      this.form.price = {
        original: this.variant.original_price / 100,
        sell: this.variant.sell_price / 100,
        discounted: this.variant.discounted_price / 100
      }
    }
  },

  // mounted() {},
  methods: {
    submitForm() {
      this.$store
        .dispatch('productVariants/save', this.form.sync())
        .then(() => {
          return this.$store.dispatch('addFlashMessage', [
            'success',
            this.messageLocaleText('resource_updated_successfully', {
              resource: this.modelNameLocaleText('product/variant')
            })
          ])
        })
        .then(() => {
          this.$parent.close()
        })
    }
  }
}
</script>
