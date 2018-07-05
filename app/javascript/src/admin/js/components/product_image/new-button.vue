<template lang="pug">

.vc-product-image-new-button
  .button.is-primary(:class="size"
                     @click="showForm")
    .icon
      i.fa.fa-plus
    span.text {{ buttonText }}

  b-modal(:active.sync="isFormActive")
    new-image-form(:product="product"
                   :variant="variant")

</template>

<script>
import NewImageForm from './form.vue'

export default {
  components: {
    NewImageForm
  },
  // mixins: [],
  props: {
    product: {
      type: Object,
      required: true
    },

    size: {
      type: String,
      required: false,
      default: () => {
        return ''
      }
    },

    variant: {
      type: Object,
      required: false
    }
  },

  data() {
    return {
      isFormActive: false
    }
  },

  computed: {
    buttonText() {
      if (this.variant) {
        return this.actionLocaleText('admin', 'create', {
          model: this.attributeLocaleText('product/image', 'images_for', { variant_name: this.variant.name })
        })
      } else {
        return this.actionLocaleText('admin', 'create', { model: this.modelNameLocaleText('product/image') })
      }
    }
  },
  // created() {},
  // mounted() {},
  methods: {
    showForm() {
      this.isFormActive = true
    }
  }
}
</script>
