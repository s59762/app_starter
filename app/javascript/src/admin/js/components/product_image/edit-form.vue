<template lang="pug">

.vc-product-image-edit-form.box.form-container-box.is-default.clearfix
  h3.subtitle {{ pageTitleLocaleText('admin', 'products', 'image_config') }}

  set-as-cover-button(:image="image"
                      @image-updated="imageUpdatedHandler")

  b-field(:label="attributeLocaleText('product/image', 'variant_id')"
          :type="errors.errorClassAt('variant_id')"
          :message="errors.get('variant_id')")
    b-select(v-model="form.variant_id"
             :loading="isLoading"
             :placeholder="messageLocaleText('help.no_variant')"
             @input="errors.clear('variant_id')"
             expanded)
      option(:label="messageLocaleText('help.no_variant')"
             :value="null")
      option(v-for="variant in variants"
             :value="variant.id")
        | {{ variant.name }} - {{ variant.sku }}

  br

  .is-pulled-right
    .button.is-primary(@click="submitForm"
                       :class="{'is-loading': isLoading}") {{ actionLocaleText('admin', 'submit') }}

</template>

<script>
import Form from 'odd-form_object'
import SetAsCoverButton from './set-as-cover-button.vue'

export default {
  components: {
    SetAsCoverButton
  },
  // mixins: [],
  props: {
    image: {
      type: Object,
      required: true
    }
  },

  data() {
    return {
      form: new Form(this.image)
    }
  },

  computed: {
    isLoading() {
      return this.$store.getters['productImages/isLoading']
    },

    errors() {
      return this.image.errors
    },

    variants() {
      return this.$store.getters['productVariants/all']
    }
  },

  // created() {},
  // mounted() {},
  methods: {
    submitForm() {
      this.$store
        .dispatch('productImages/assignToVariant', this.form.sync())
        .then(() => {
          return this.$store.dispatch('addFlashMessage', [
            'success',
            this.messageLocaleText('resource_updated_successfully', {
              resource: this.modelNameLocaleText('product/image')
            })
          ])
        })
        .then(() => {
          this.$parent.close()
        })
    },

    imageUpdatedHandler() {
      this.$parent.close()
    }
  }
}
</script>
