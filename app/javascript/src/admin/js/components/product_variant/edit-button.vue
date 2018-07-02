<template lang="pug">

.vc-product-variant-edit-button
  .button.is-info.is-block(@click="showForm"
                           :class="size")
    .icon
      i.fa.fa-pencil
    span {{ actionLocaleText('admin', 'edit') }}
  b-modal(:active.sync="isFormActive")
    variant-form(:variant="variant")


</template>

<script>
import VariantForm from './form.vue'
export default {
  components: {
    VariantForm
  },
  // mixins: [],
  props: {
    variant: {
      type: Object,
      required: true
    },

    size: {
      type: String,
      required: false
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
