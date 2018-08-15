<template lang="pug">

.vc-product-option-value-form.box.form-container-box.is-default.clearfix
  h3.subtitle {{ formTitle }}

  b-field(:label="attributeLocaleText('product', 'option_value')"
          :type="errors.errorClassAt('value')"
          :message="errors.get('value')")
    b-input(type="text"
            placeholder="e.g. Red"
            v-model="form.value"
            @input="errors.clear('value')")

  br

  .is-pulled-right
    .button.is-primary(@click="submitForm"
                       :class="{'is-loading': isLoading}") {{ actionLocaleText('admin', 'submit') }}

</template>

<script>
import Form from 'odd-form_object'
import ProductOptionValue from '../../../../shared/resource_models/product_option_value'

export default {
  // components: {},
  // mixins: [],
  props: {
    optionType: {
      type: Object,
      required: true
    },

    optionValue: {
      type: Object,
      required: false,
      default: () => {
        return new ProductOptionValue()
      }
    }
  },

  data() {
    return {
      form: new Form(this.optionValue)
    }
  },

  computed: {
    isLoading() {
      return this.$store.getters['productOptionValues/isLoading']
    },

    errors() {
      return this.form.model.errors
    },

    formTitle() {
      if (this.optionValue.isNewRecord()) {
        return this.pageTitleLocaleText('admin', 'products', 'new_option_value')
      } else {
        return this.pageTitleLocaleText('admin', 'products', 'edit_option_value')
      }
    },

    flashMessage() {
      if (this.optionValue.isNewRecord()) {
        return this.messageLocaleText('resource_added_successfully', {
          resource: this.attributeLocaleText('product', 'option_value')
        })
      } else {
        return this.messageLocaleText('resource_updated_successfully', {
          resource: this.attributeLocaleText('product', 'option_value')
        })
      }
    }
  },
  // created() {},
  mounted() {
    if (this.optionValue.isNewRecord()) this.form.option_type_id = this.optionType.id
  },

  methods: {
    submitForm() {
      this.$store
        .dispatch('productOptionValues/save', this.form.sync())
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
