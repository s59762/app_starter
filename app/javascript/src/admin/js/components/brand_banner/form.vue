<template lang="pug">

.vc-brand-banner-form.box.form-container-box.is-default.clearfix
  h3.subtitle {{ title }}

  b-field(:label="attributeLocaleText('brand/banner', 'image')"
          :type="errors.errorClassAt('image')"
          :message="errors.get('image')")
    .image-wrapper.has-image(v-if="!banner.isNewRecord() && !isImageCropperActive")
      img.current-image(:src="banner.image.url")
      .update-image-trigger(@click="showImageCropper") {{ messageLocaleText('help.click_for_update_image') }}
    .logo-wrapper(v-else)
      croppa(v-model="image"
             :placeholder="messageLocaleText('help.please_select_a_picture')"
             :placeholder-font-size="38"
             remove-button-color="red"
             :remove-button-size="25"
             canvas-color="#eee"
             :width="512"
             :height="176"
             :quality="3.75"
             :prevent-white-space="true"
             :show-loading="true"
             @new-image="errors.clear('image')")

  b-field(:label="attributeLocaleText('brand/banner', 'alt_text')"
          :type="errors.errorClassAt('alt_text')"
          :message="errors.get('alt_text')")
    b-input(type="text"
            v-model="altText"
            @input="errors.clear('alt_text')")

  br

  .is-pulled-right
    .button.is-primary(@click="submitForm"
                       :class="{'is-loading': isLoading}") {{ actionLocaleText('admin', 'submit') }}

</template>

<script>
import BrandBanner from '../../../../shared/resource_models/brand_banner.js'

export default {
  // components: {},
  // mixins: [],
  props: {
    brand: {
      type: Object,
      required: true
    },

    banner: {
      type: Object,
      required: false,
      default: () => {
        return new BrandBanner()
      }
    }
  },

  data() {
    return {
      image: null,
      altText: '',
      isImageCropperActive: false
    }
  },

  computed: {
    title() {
      if (this.banner.isNewRecord()) return this.pageTitleLocaleText('admin', 'brands', 'new_banner')

      return this.pageTitleLocaleText('admin', 'brands', 'edit_banner')
    },

    flashMessage() {
      const action = this.banner.isNewRecord() ? 'added' : 'updated'

      return [
        'success',
        this.messageLocaleText(`resource_${action}_successfully`, {
          resource: this.modelNameLocaleText('brand/banner')
        })
      ]
    },

    isLoading() {
      return this.$store.getters['brandBanners/isLoading']
    },

    errors() {
      return this.banner.errors
    }
  },
  created() {
    this.altText = this.banner.alt_text || ''
  },
  // mounted() {},
  methods: {
    showImageCropper() {
      this.isImageCropperActive = true
    },

    generateFormData() {
      let formData = new FormData()

      if (this.image === null || !this.image.hasImage()) {
        return new Promise((resolve, reject) => {
          formData.append('banner[brand_id]', this.brand.id)
          formData.append('banner[alt_text]', this.altText)

          resolve(formData)
        })
      } else {
        return new Promise((resolve, reject) => {
          this.image
            .promisedBlob('image/jpeg', '0.8')
            .then(blob => {
              const file = new File([blob], 'banner.jpg', {
                type: 'image/jpeg'
              })

              formData.append('banner[image]', file)
              formData.append('banner[alt_text]', this.altText)
              formData.append('banner[brand_id]', this.brand.id)
              resolve(formData)
            })
            .catch(errors => {
              reject(errors)
            })
        })
      }
    },

    submitForm() {
      this.generateFormData()
        .then(formData => {
          return this.$store.dispatch('brandBanners/save', {
            model: this.banner,
            formData
          })
        })
        .then(() => {
          return this.$store.dispatch('addFlashMessage', this.flashMessage)
        })
        .then(() => {
          this.$parent.close()
        })
    }
  }
}
</script>
