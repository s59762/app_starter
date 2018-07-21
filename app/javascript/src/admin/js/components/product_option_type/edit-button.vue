<template lang="pug">

.vc-product-option-type-edit-button.option-button
  .button.is-small.is-info.edit-button(@click="showForm")
    .icon
      i.fa.fa-pencil

  b-modal(:active.sync="isFormActive"
          ref="modal")
    .box.form-container-box.is-default.clearfix
      h3.subtitle {{ pageTitleLocaleText('admin', 'products', 'edit_option_type') }}

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
import Form from 'odd-form_object'

export default {
  // components: {},
  // mixins: [],
  props: {
    optionType: {
      type: Object,
      required: true
    }
  },

  data() {
    return {
      form: new Form(this.optionType),
      isFormActive: false
    }
  },

  computed: {
    isLoading() {
      return this.$store.getters['productOptionTypes/isLoading']
    },

    errors() {
      return this.optionType.errors
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
            this.messageLocaleText('resource_updated_successfully', {
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
