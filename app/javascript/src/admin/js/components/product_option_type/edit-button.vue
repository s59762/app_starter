<template lang="pug">

.vc-product-option-type-edit-button.option-button
  .button.is-small.is-info.edit-button(@click="showForm")
    .icon
      i.fa.fa-pencil

  b-modal(:active.sync="isFormActive"
          ref="modal")
    option-type-form(:option-type="optionType")

</template>

<script>
import OptionTypeForm from './form.vue'

export default {
  components: {
    OptionTypeForm
  },
  // mixins: [],
  props: {
    optionType: {
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
