<template lang="pug">

.vc-brand-banner-new-button.option-button
  button.button.is-small.is-primary(@click="showForm"
                                    data-behavior="new-banner-button")
    span.icon
      i.fa.fa-plus
    span {{actionLocaleText('admin', 'new', { model: modelNameLocaleText('brand/banner') })}}
  b-modal(:active.sync="isFormActive")
    brand-banner-form(:brand="brand")

</template>

<script>
import BrandBannerForm from './form.vue'

export default {
  components: {
    BrandBannerForm
  },
  // mixins: [],
  props: {
    brand: {
      type: Object,
      required: true
    }
  },

  data() {
    return {
      isFormActive: false
    }
  },
  // computed: {},
  // created() {},
  // mounted() {},
  methods: {
    showForm() {
      this.isFormActive = true
    }
  }
}
</script>
