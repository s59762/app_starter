<template lang="pug">

.vc-product-variant-form.box.form-container-box.is-default.clearfix
  h3.subtitle {{ formTitle }}

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

  section.section(v-if="optionTypes.length > 0")
    h4.section-title {{pageTitleLocaleText('admin', 'products', 'option_type_fields')}}

    .columns.is-multiline
      .column.is-half(v-for="optionType in optionTypes"
                      :key="optionType.id")
        b-field(:label="optionType.name"
                :type="errors.errorClassAt('option_value_ids')"
                :message="errors.get('option_value_ids')")
          b-select(v-model="optionTypeAndValuePairs[optionType.id]"
                   :placeholder="messageLocaleText('help.please_select_option_value')"
                   @input="errors.clear('option_value_id')"
                   expanded)
            option {{messageLocaleText('help.choose_none')}}
            option(v-for="optionValue in relatedOptionValuesOf(optionType)"
                  :value="optionValue.id"
                  :key="optionValue.id") {{ optionValue.value }}

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
    product: {
      type: Object,
      required: false,
      default: () => {
        return null
      }
    },

    variant: {
      type: Object,
      required: false,
      default: () => {
        return new ProductVariant()
      }
    }
  },

  data() {
    return {
      form: new Form(this.variant),
      optionTypeAndValuePairs: {}
    }
  },

  computed: {
    isLoading() {
      return this.$store.getters['productVariants/isLoading']
    },

    errors() {
      return this.variant.errors
    },

    formTitle() {
      if (this.variant.isNewRecord()) {
        return this.pageTitleLocaleText('admin', 'products', 'new_variant')
      } else {
        return this.pageTitleLocaleText('admin', 'products', 'edit_variant')
      }
    },

    flashMessage() {
      if (this.variant.isNewRecord()) {
        return this.messageLocaleText('resource_added_successfully', {
          resource: this.modelNameLocaleText('product/variant')
        })
      } else {
        return this.messageLocaleText('resource_updated_successfully', {
          resource: this.modelNameLocaleText('product/variant')
        })
      }
    },

    optionTypes() {
      return this.$store.getters['productOptionTypes/all']
    }
  },

  created() {
    if (this.variant.isNewRecord()) {
      this.form.price = {
        original: 0,
        sell: 0,
        discounted: 0
      }
      this.form.product_id = this.product.id
      this.form.option_value_ids = []
    } else {
      this.form.price = {
        original: this.variant.original_price / 100,
        sell: this.variant.sell_price / 100,
        discounted: this.variant.discounted_price / 100
      }
    }

    this.parseOptionTypeAndValuePairs()
  },

  // mounted() {},
  methods: {
    parseOptionTypeAndValuePairs() {
      this.optionTypes.forEach(optionType => {
        let selectedValue = this.relatedOptionValuesOf(optionType).find(optionValue =>
          this.form.option_value_ids.includes(parseInt(optionValue.id))
        )

        this.optionTypeAndValuePairs[optionType.id] = selectedValue && selectedValue.id
      })
    },

    relatedOptionValuesOf(optionType) {
      return this.$store.getters['productOptionValues/all'].filter(
        value => String(value.option_type_id) === optionType.id
      )
    },

    submitForm() {
      this.form.option_value_ids = this.optionTypes.map(optionType =>
        parseInt(this.optionTypeAndValuePairs[optionType.id])
      )

      this.$store
        .dispatch('productVariants/save', this.form.sync())
        .then(() => {
          return this.$store.dispatch('addFlashMessage', ['success', this.flashMessage])
        })
        .then(() => {
          this.$parent.close()
        })
    }
  }
}
</script>
