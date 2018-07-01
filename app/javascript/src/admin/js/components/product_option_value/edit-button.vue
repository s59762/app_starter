<template lang="pug">

.vc-product-option-value-edit-button
  .button.is-info(@click="showForm")
    .icon
      i.fa.fa-pencil
  b-modal(:active.sync="isFormActive"
          ref="modal")
    .box.form-container-box.is-default.clearfix
      h3.subtitle {{ pageTitleLocaleText('admin', 'products', 'edit_option_value') }}

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

export default {
  // components: {},
  // mixins: [],
  props: {
    optionValue: {
      type: Object,
      required: true
    }
  },

  data() {
    return {
      form: new Form(this.optionValue),
      isFormActive: false
    }
  },

  computed: {
    isLoading() {
      return this.$store.getters['productOptionValues/isLoading']
    },

    errors() {
      return this.optionValue.errors
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
            this.messageLocaleText('resource_updated_successfully', {
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
