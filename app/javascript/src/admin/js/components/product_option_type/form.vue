<template lang="pug">

.vc-product-option-type-form.box.form-container-box.is-default.clearfix
  h3.subtitle {{ formTitle }}

  b-field(:label="attributeLocaleText('product', 'option_name')"
          :type="errors.errorClassAt('name')"
          :message="errors.get('name')")
    b-input(type="text"
            placeholder="e.g. Color"
            v-model="form.name"
            @input="errors.clear('name')")

  br

  .is-pulled-right
    .button.is-primary(@click="submitForm"
                       :class="{'is-loading': isLoading}") {{ actionLocaleText('admin', 'submit') }}

</template>

<script>
import ProductOptionType from '../../../../shared/resource_models/product_option_type.js'
import Form from 'odd-form_object'

export default {
  // components: {},
  // mixins: [],
  props: {
    optionType: {
      type: Object,
      required: false,
      default: () => {
        return new ProductOptionType()
      }
    },

    product: {
      type: Object,
      required: false,
      default: () => {
        return null
      }
    }
  },

  data() {
    return {
      form: new Form(this.optionType)
    }
  },
  computed: {
    isLoading() {
      return this.$store.getters['productOptionTypes/isLoading']
    },

    errors() {
      return this.optionType.errors
    },

    formTitle() {
      if (this.optionType.isNewRecord()) {
        return this.pageTitleLocaleText('admin', 'products', 'new_option_type')
      } else {
        return this.pageTitleLocaleText('admin', 'products', 'edit_option_type')
      }
    },

    flashMessage() {
      if (this.optionType.isNewRecord()) {
        return this.messageLocaleText('resource_added_successfully', {
          resource: this.attributeLocaleText('product', 'option_name')
        })
      } else {
        return this.messageLocaleText('resource_updated_successfully', {
          resource: this.attributeLocaleText('product', 'option_name')
        })
      }
    }
  },
  // created() {},
  mounted() {
    if (this.optionType.isNewRecord()) this.form.product_id = this.product.id
  },

  methods: {
    submitForm() {
      this.$store
        .dispatch('productOptionTypes/save', this.form.sync())
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
