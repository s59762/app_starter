<template lang="pug">

.vc-brand-edit-button.option-button
  button.button.is-small.is-info(@click="showForm"
                                 data-behavior="edit-brand-button")
    span.icon
      i.fa.fa-pencil
    span {{ buttonText }}
  b-modal(:active.sync="isFormActive"
          :can-cancel="['x', 'outside']")
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
    },

    buttonText: {
      type: String,
      required: false,
      default: () => {
        return I18n.t('actions.admin.edit')
      }
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
