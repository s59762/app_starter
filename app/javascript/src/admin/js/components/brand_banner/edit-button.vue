<template lang="pug">

.vc-brand-banner-edit-button.option-button
  button.button.is-small.is-info(@click="showForm"
                                 data-behavior="edit-banner-button")
    span.icon
      i.fa.fa-pencil
    span {{actionLocaleText('admin', 'edit')}}
  b-modal(:active.sync="isFormActive")
    brand-banner-form(:brand="brand"
                      :banner="banner")

</template>

<script>
import BrandBannerForm from './form'

export default {
  components: {
    BrandBannerForm
  },
  // mixins: [],
  props: {
    brand: {
      type: Object,
      required: true
    },

    banner: {
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
