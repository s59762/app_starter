<template lang="pug">

.vc-product-variant-update-stock-button
  .button.is-block(:class="buttonTypeClasses"
                   @click="showForm")
    .icon
      i.fa(:class="buttonIconClasses")
    span {{ actionLocaleText('admin', `${action}_stock`) }}
  b-modal(:active.sync="isFormActive"
          ref="modal")
    .box.form-container-box.is-default.clearfix
      h3.subtitle {{ pageTitleLocaleText('admin', 'products', `${action}_stock_form`) }}

      b-field(:label="attributeLocaleText('product/variant', 'quantity')"
              :type="errors.errorClassAt('quantity')"
              :message="errors.get('quantity')")
        b-input(type="number"
                min="1"
                v-model="form.stock_params.quantity"
                @input="errors.clear('quantity')")

      b-field(:label="attributeLocaleText('product/variant', 'reason')"
              :type="errors.errorClassAt('reason')"
              :message="errors.get('reason')")
        b-input(type="textarea"
                v-model="form.stock_params.reason"
                @input="errors.clear('reason')")

      br

      .is-pulled-right
        .button.is-primary(@click="submitForm"
                           :class="{'is-loading': isLoading}") {{ actionLocaleText('admin', 'submit') }}

</template>

<script>
import Form from 'odd-form_object'

export default {
  // components: {},
  // mixins: [],
  props: {
    variant: {
      type: Object,
      required: true
    },

    action: {
      type: String,
      required: false,
      validator: value => {
        return ['increase', 'decrease'].includes(value)
      },
      default: () => {
        return 'increase'
      }
    },

    size: {
      type: String,
      required: false,
      default: () => {
        return 'is-small'
      }
    }
  },

  data() {
    return {
      isFormActive: false,
      form: new Form(this.variant)
    }
  },

  computed: {
    buttonTypeClasses() {
      let classList = {
        'is-success': this.action === 'increase',
        'is-danger': this.action === 'decrease'
      }

      classList[this.size] = true

      return classList
    },

    buttonIconClasses() {
      return {
        'fa-plus': this.action === 'increase',
        'fa-minus': this.action === 'decrease'
      }
    },

    isLoading() {
      return this.$store.getters['productVariants/isLoading']
    },

    errors() {
      return this.variant.errors
    }
  },

  created() {
    this.form.stock_params = this.stockParamsTemplate()
  },

  // mounted() {},
  methods: {
    stockParamsTemplate() {
      return {
        quantity: 1,
        action: this.action,
        reason: ''
      }
    },

    showForm() {
      this.isFormActive = true
    },

    submitForm() {
      this.$store
        .dispatch('productVariants/updateStock', this.form.sync())
        .then(() => {
          return this.$store.dispatch('addFlashMessage', [
            'success',
            this.messageLocaleText('resource_updated_successfully', {
              resource: this.modelNameLocaleText('product/variant')
            })
          ])
        })
        .then(() => {
          this.form.stock_params = this.stockParamsTemplate()
          this.$refs.modal.close()
        })
    }
  }
}
</script>
