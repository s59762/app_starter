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

  section.section(v-if="optionTypesWidthValues.length > 0")
    h4.section-title {{pageTitleLocaleText('admin', 'products', 'option_type_fields')}}

    .columns.is-multiline
      .column.is-half(v-for="optionType in optionTypesWidthValues"
              :key="optionType.id")
        b-field(:label="optionType.name"
                :type="errors.errorClassAt('option_value_ids')"
                :message="errors.get('option_value_ids')")
          b-select(v-model="optionType.selected_value_id"
                  :placeholder="messageLocaleText('help.please_select_option_value')"
                  @input="errors.clear('option_value_id')"
                  expanded)
            option {{messageLocaleText('help.choose_none')}}
            option(v-for="optionValue in optionType.option_values"
                  :value="optionValue.id"
                  :key="optionValue.id")
              | {{ optionValue.value }}

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
      form: new Form(this.variant),
      optionTypesWidthValues: []
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
    this.buildOptionTypesSelectProperty()

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
    buildOptionTypesSelectProperty() {
      let optionTypes = this.$store.getters['productOptionTypes/all']

      this.optionTypesWidthValues = optionTypes.map(optionType => {
        optionType.option_values = this.relatedOptionValuesOf(optionType)
        optionType['selected_value_id'] = this.form.model.option_value_ids.filter(id => {
          let optionIds = optionType.option_values.map(optionValue => {
            return optionValue.id
          })
          return optionIds.includes(String(id))
        })[0]
        return optionType
      })
    },
    relatedOptionValuesOf(optionType) {
      return this.$store.getters['productOptionValues/all'].filter(
        value => String(value.option_type_id) === optionType.id
      )
    },
    syncOptionValues() {
      let ids = this.optionTypesWidthValues.map(optionType => {
        return parseInt(optionType.selected_value_id)
      })
      this.form.option_value_ids = ids.filter(id => id)
    },
    submitForm() {
      this.syncOptionValues()
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
