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
      form: new Form(this.brand)
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
    submitForm() {
      this.$store
        .dispatch('brands/save', this.form.sync())
        .then(() => {
          this.$store.dispatch('addFlashMessage', this.flashMessage)
        })
        .then(() => {
          this.$parent.close()
        })
    }
  }
}
</script>
