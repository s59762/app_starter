<template lang="pug">

.vc-brand-edit-button
  button.button.is-small.is-info(@click="showForm"
                                 data-behavior="edit-brand-button")
    span.icon
      i.fa.fa-pencil
    span {{ actionLocaleText('admin', 'edit') }}
  b-modal(:active.sync="isFormActive")
    brand-form(:brand="brand")

</template>

<script>
import BrandForm from './form.vue'

export default {
  components: {
    BrandForm
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
