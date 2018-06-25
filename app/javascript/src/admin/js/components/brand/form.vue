<template lang="pug">

.vc-brand-form.box.form-container-box.is-default.clearfix
  h3.subtitle {{ formTitle }}

  b-field(:label="attributeLocaleText('brand', 'name')"
          :type="errors.errorClassAt('name')"
          :message="errors.get('name')")
    b-input(type="text"
            placeholder="e.g. Burberry"
            v-model="form.name"
            @input="errors.clear('name')")

  b-field(:label="attributeLocaleText('brand', 'logo')"
          :type="errors.errorClassAt('logo')"
          :message="errors.get('logo')")
    .logo-wrapper.has-logo(v-if="brand.hasLogo() && !isLogoImageCropperActive")
      img.current-logo(:src="brand.logo.url")
      .update-logo-trigger(@click="showLogoImageCropper") {{ messageLocaleText('help.click_for_update_logo') }}
    .logo-wrapper(v-else)
      croppa(v-model="logoImage"
           :placeholder="messageLocaleText('help.please_select_a_picture')"
           :placeholder-font-size="24"
           remove-button-color="red"
           :remove-button-size="25"
           canvas-color="#eee"
           :width="200"
           :height="200"
           :quality="2.56"
           :prevent-white-space="true"
           :show-loading="true")

  b-field(:label="attributeLocaleText('brand', 'introduce')"
          :type="errors.errorClassAt('introduce')"
          :message="errors.get('introduce') || messageLocaleText('help.please_make_words_count_about', { count: 200 })")
    b-input(type="textarea"
            placeholder="e.g. Our vision is to establish Burberry’s position firmly in luxury fashion. By sharpening our positioning in the most rewarding and enduring segment of the market, we will drive sustainable growth and higher margins over time, while continuing to deliver attractive returns."
            v-model="form.introduce"
            @input="errors.clear('introduce')")

  b-field(:label="attributeLocaleText('brand', 'description')"
          :type="errors.errorClassAt('description')"
          :message="errors.get('description')")
    b-input(type="textarea"
            v-model="form.description"
            @input="errors.clear('description')")


  br

  .is-pulled-right
    .button.is-primary(@click="submitForm"
                       :class="{'is-loading': isLoading}") {{ actionLocaleText('admin', 'submit') }}

</template>

<script>
import Brand from '../../../../shared/resource_models/brand.js'
import Form from 'odd-form_object'

export default {
  // components: {},
  // mixins: [],
  props: {
    brand: {
      type: Object,
      required: false,
      default() {
        return new Brand()
      }
    }
  },

  data() {
    return {
      form: new Form(this.brand),
      logoImage: null,
      isLogoImageCropperActive: false
    }
  },

  computed: {
    isLoading() {
      return this.$store.getters['brands/isLoading']
    },

    errors() {
      return this.brand.errors
    },

    formTitle() {
      if (this.brand.isNewRecord()) {
        return this.pageTitleLocaleText('admin', 'brands', 'new')
      } else {
        return this.pageTitleLocaleText('admin', 'brands', 'edit')
      }
    },

    flashMessage() {
      if (this.brand.isNewRecord()) {
        return [
          'success',
          this.messageLocaleText('resource_added_successfully', { resource: this.modelNameLocaleText('brand') })
        ]
      } else {
        return [
          'success',
          this.messageLocaleText('resource_updated_successfully', { resource: this.modelNameLocaleText('brand') })
        ]
      }
    }
  },
  // created() {},
  // mounted() {},
  methods: {
    showLogoImageCropper() {
      this.isLogoImageCropperActive = true
    },

    generateFormData() {
      let formData = new FormData()

      return new Promise((resolve, reject) => {
        this.logoImage
          .promisedBlob('image/jpeg', '0.8')
          .then(blob => {
            const file = new File([blob], `logo.jpg`)

            formData.append('brand[logo]', file)
            resolve(formData)
          })
          .catch(errors => {
            reject(errors)
          })
      })
    },

    submitForm() {
      let model = this.brand

      this.$store
        .dispatch('brands/save', this.form.sync())
        .then(response => {
          if (model.isNewRecord()) model.id = response.data.data.id

          return this.generateFormData()
        })
        .then(formData => {
          return this.$store.dispatch('brands/updateLogo', {
            model,
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
