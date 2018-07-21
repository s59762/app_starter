<template lang="pug">

.vc-product-category-new-sub-category-button.option-button
  .button.is-small.is-primary(@click="openForm"
                              data-behavior="new-sub-category-button")
    span.icon
      i.fa.fa-plus
    span {{actionLocaleText('admin', 'create', {model: attributeLocaleText('product_category', 'sub_categories')})}}
  b-modal(:active.sync="isFormActive")
    new-product-category-form(:parent-id="parent.id"
                              @product-category-added="categoryAddedHandler")


</template>

<script>
import NewProductCategoryForm from './new-form'

export default {
  components: {
    NewProductCategoryForm
  },

  // mixins: [],

  props: {
    parent: {
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
    },

    categoryAddedHandler() {
      this.$emit('product-category-added')
    }
  }
}
</script>
