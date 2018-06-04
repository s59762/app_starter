<template lang="pug">

span.vc-product-category-new-button
  .button.is-small.is-primary(@click="openForm"
                              data-behavior="new-product-category-button")
    span.icon
      i.fa.fa-plus
    span {{actionLocaleText('admin', 'create', {model: modelNameLocaleText('product_category')})}}
  b-modal(:active.sync="isFormActive")
    new-product-category-form(@product-category-added="categoryAddedHandler")


</template>

<script>
import NewProductCategoryForm from './new-form'

export default {
  components: {
    NewProductCategoryForm
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
    openForm() {
      this.isFormActive = true
    },

    categoryAddedHandler() {
      this.$emit('product-category-added')
    }
  }
}
</script>
