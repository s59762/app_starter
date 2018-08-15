<template lang="pug">

.vc-product-option-value-edit-button.option-button
  .button.is-info(@click="showForm")
    .icon
      i.fa.fa-pencil
  b-modal(:active.sync="isFormActive")
    option-value-form(:option-type="optionType"
                      :option-value="optionValue")

</template>

<script>
import OptionValueForm from './form.vue'

export default {
  components: {
    OptionValueForm
  },
  // mixins: [],
  props: {
    optionType: {
      type: Object,
      required: true
    },

    optionValue: {
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
