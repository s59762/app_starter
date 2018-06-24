<template lang="pug">

.vc-brand-new-button
  button.button.is-small.is-primary(@click="showForm"
                                    data-behavior="new-brand-button")
    span.icon
      i.fa.fa-plus
    span {{ actionLocaleText('admin', 'create', { model: modelNameLocaleText('brand') }) }}
  b-modal(:active.sync="isFormActive")
    brand-form

</template>

<script>
import BrandForm from './form.vue'

export default {
  components: {
    BrandForm
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
