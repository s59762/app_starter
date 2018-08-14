<template lang="pug">

.vc-product-option-type-new-button
  .add-option-type-button.button.is-default.is-block(@click="showForm")
    .icon
      i.fa.fa-plus
    span {{actionLocaleText('admin', 'add_product_option_type')}}

  b-modal(:active.sync="isFormActive"
          ref="modal")
    .box.form-container-box.is-default.clearfix
      h3.subtitle {{ pageTitleLocaleText('admin', 'products', 'new_option_type') }}

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
import ProductOptionType from '../../../../shared/resource_models/product_option_type'
import Form from 'odd-form_object'

export default {
  // components: {},
  // mixins: [],
  props: {
    productId: {
      type: String,
      required: true
    }
  },
  data() {
    return {
      form: new Form(
        new ProductOptionType({
          product_id: this.productId
        })
      ),
      isFormActive: false
    }
  },
  computed: {
    isLoading() {
      return this.$store.getters['productOptionType/isLoading']
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
        .dispatch('productOptionTypes/save', this.form.sync())
        .then(() => {
          return this.$store.dispatch('addFlashMessage', [
            'success',
            this.messageLocaleText('resource_added_successfully', {
              resource: this.attributeLocaleText('product', 'option_name')
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
