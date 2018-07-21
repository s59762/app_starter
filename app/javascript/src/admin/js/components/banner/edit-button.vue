<template lang="pug">

span.vc-banner-edit-button.option-button
  button.button.is-small.is-info(@click="showForm"
                                 data-behavior="edit-banner-button")
    span.icon
      i.fa.fa-pencil
    span {{actionLocaleText('admin', 'edit')}}
  b-modal(:active.sync="isFormActive")
    banner-form(:banner="banner")

</template>

<script>
import BannerForm from './form.vue'

export default {
  components: {
    BannerForm
  },
  // mixins: [],
  props: {
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
