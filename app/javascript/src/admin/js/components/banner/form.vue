<template lang="pug">

.vc-banner-form.box.form-container-box.is-default.clearfix
  h3.subtitle {{ title }}

  b-field(:label="attributeLocaleText('banner', 'image')"
          :type="errors.errorClassAt('image')"
          :message="errors.get('image')")
    .image-wrapper.has-image(v-if="!banner.isNewRecord() && !isImageCropperActive"
                             :class="currentType")
      img.current-image(:src="banner.image.url")
      .update-image-trigger(@click="showImageCropper") {{ messageLocaleText('help.click_for_update_image') }}
    .logo-wrapper(v-else
                  :class="currentType")
      croppa(v-model="image"
           :placeholder="messageLocaleText('help.please_select_a_picture')"
           :placeholder-font-size="38"
           remove-button-color="red"
           :remove-button-size="25"
           canvas-color="#eee"
           :width="sizeForChosenType.width"
           :height="sizeForChosenType.height"
           :quality="qualityForChosenType"
           :prevent-white-space="true"
           :show-loading="true"
           @new-image="errors.clear('image')")

  b-field(v-if="banner.isNewRecord()"
          :label="attributeLocaleText('banner', 'use_type')"
          :type="errors.errorClassAt('use_type')"
          :message="errors.get('use_type')")
    b-select(v-model="currentType"
             :loading="isLoading"
             @input="errors.clear('use_type')"
             expanded)
      option(v-for="type in useTypes"
             :value="type")
        | {{ enumLocaleText('banner', 'use_type', type) }}

  b-field(:label="attributeLocaleText('banner', 'alt_text')"
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
import Banner from '../../../../shared/resource_models/banner.js'

export default {
  // components: {},
  // mixins: [],
  props: {
    banner: {
      type: Object,
      required: false,
      default: () => {
        return new Banner()
      }
    }
  },

  data() {
    return {
      currentType: null,
      image: null,
      altText: '',
      isImageCropperActive: false
    }
  },

  computed: {
    title() {
      if (this.banner.isNewRecord()) return this.pageTitleLocaleText('admin', 'banners', 'new')

      return this.pageTitleLocaleText('admin', 'banners', 'edit')
    },

    flashMessage() {
      const action = this.banner.isNewRecord() ? 'added' : 'updated'

      return [
        'success',
        this.messageLocaleText(`resource_${action}_successfully`, { resource: this.modelNameLocaleText('banner') })
      ]
    },

    isLoading() {
      return this.$store.getters['banners/isLoading']
    },

    errors() {
      return this.banner.errors
    },

    useTypes() {
      return this.$store.getters['banners/useTypes']
    },

    qualityForChosenType() {
      if (this.currentType === 'sign_up') return 1.429

      return 3.75
    },

    sizeForChosenType() {
      if (this.currentType === 'sign_up') return { width: 504, height: 903 }

      return {
        width: 512,
        height: 176
      }
    }
  },

  created() {
    if (this.useTypes.length > 0) {
      this.currentType = this.banner.use_type || this.useTypes[0]
      this.altText = this.banner.alt_text || ''
    } else {
      this.$store.dispatch('banners/useTypes').then(() => {
        this.currentType = this.banner.use_type || this.useTypes[0]
        this.altText = this.banner.alt_text || ''
      })
    }
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
          if (this.banner.isNewRecord()) formData.append('banner[use_type]', this.currentType)
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
              if (this.banner.isNewRecord()) formData.append('banner[use_type]', this.currentType)
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
          return this.$store.dispatch('banners/save', {
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
