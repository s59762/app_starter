<template lang="pug">

span.vc-banner-new-button.option-button
  button.button.is-small.is-primary(@click="showForm"
                                 data-behavior="new-banner-button")
    span.icon
      i.fa.fa-plus
    span {{actionLocaleText('admin', 'new', { model: modelNameLocaleText('banner') })}}
  b-modal(:active.sync="isFormActive")
    banner-form

</template>

<script>
import BannerForm from './form.vue'

export default {
  components: {
    BannerForm
  },
  // mixins: [],
  // props: {},
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
