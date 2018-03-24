<template lang="pug">

span.product-category-edit-button
  .button.is-small.is-info(@click="openForm")
    span.icon
      i.fa.fa-pencil
    span {{actionLocaleText('admin', 'edit')}}
  b-modal(:active.sync="isFormActive")
    edit-form.form-modal(:category="category")

</template>

<script>
import EditForm from './edit-form'

export default {
  components: {
    EditForm
  },

  // mixins: [],

  props: {
    category: {
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
    openForm() {
      this.isFormActive = true
    }
  }
}
</script>
