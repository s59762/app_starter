<template lang="pug">

.vc-product-option-value-new-button
  .button.is-small.is-info(@click="showForm")
    .icon
      i.fa.fa-plus
    span {{ actionLocaleText('admin', 'add_product_option_value') }}
  b-modal(:active.sync="isFormActive"
          ref="modal")
    .box.form-container-box.is-default.clearfix
      h3.subtitle {{ pageTitleLocaleText('admin', 'products', 'new_option_value') }}

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
import ProductOptionValue from '../../../../shared/resource_models/product_option_value'
import Form from 'odd-form_object'

export default {
  // components: {},
  // mixins: [],
  props: {
    optionTypeId: {
      type: String,
      required: true
    }
  },
  data() {
    return {
      form: new Form(new ProductOptionValue({ option_type_id: this.optionTypeId })),
      isFormActive: false
    }
  },
  computed: {
    isLoading() {
      return this.$store.getters['productOptionValues/isLoading']
    },

    errors() {
      return this.form.model.errors
    }
  },
  // created() {},
  // mounted() {},
  methods: {
    showForm() {
      this.isFormActive = true
    },

    submitForm() {
      this.$store
        .dispatch('productOptionValues/save', this.form.sync())
        .then(() => {
          return this.$store.dispatch('addFlashMessage', [
            'success',
            this.messageLocaleText('resource_added_successfully', {
              resource: this.attributeLocaleText('product', 'option_value')
            })
          ])
        })
        .then(() => {
          this.$refs.modal.close()
        })
    }
  }
}
</script>
