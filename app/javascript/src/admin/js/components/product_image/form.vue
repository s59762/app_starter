<template lang="pug">

.vc-product-image-form.box.form-container-box.is-default.clearfix
  h3.subtitle {{ pageTitleLocaleText('admin', 'products', 'upload_images') }}

  label.label
    b &nbsp;{{ product.name }}&nbsp;
    b(v-if="variant") &nbsp;- {{ variant.name }} （{{ variant.sku }}）
    span 的圖片

  b-field
    b-upload(v-model='imageFiles'
             multiple
             drag-drop)
      section.section
        .content.has-text-centered
          p
            b-icon(icon='upload'
                   size='is-large')
          p {{ messageLocaleText('help.drop_your_files_here_or_click_to_upload') }}
  .file-previews
    .preview-unit(v-for='(file, index) in imageFiles'
                  :key='index')
      .preview-image(:style="`background-image: url('${readFile(file)}')`")
        .delete-button(@click="deleteFile(index)")
          i.fa.fa-close





  br

  .is-pulled-right
    .button.is-primary(@click="submitForm"
                       :class="{'is-loading': isLoading}") {{ actionLocaleText('admin', 'submit') }}

</template>

<script>
export default {
  // components: {},
  // mixins: [],
  props: {
    product: {
      type: Object,
      required: true
    },

    variant: {
      type: Object,
      required: false
    }
  },

  data() {
    return {
      imageFiles: []
    }
  },

  computed: {
    isLoading() {
      return this.$store.getters['products/isLoading']
    }
  },
  // created() {},
  // mounted() {},
  methods: {
    submitForm() {
      this.$store.dispatch('products/uploadImages', this.generateFormData()).then(() => {
        this.$parent.close()
      })
    },

    readFile(file) {
      return URL.createObjectURL(file)
    },

    deleteFile(index) {
      this.imageFiles.splice(index, 1)
    },

    generateFormData() {
      let formData = new FormData()

      formData.append('product[use_case]', 'normal')
      formData.append('product[product_id]', this.product.id)
      if (this.variant) formData.append('product[variant_id]', this.variant.id)
      this.imageFiles.forEach(file => {
        formData.append('product[images][]', file)
      })

      return formData
    }
  }
}
</script>
