<template lang="pug">

.product-category-new-form.box.form-container-box.is-default.clearfix
  h3.subtitle {{pageTitleLocaleText('admin', 'product_categories', 'new')}}

  b-field(:label="attributeLocaleText('product_category', 'name')"
          :type="errors.errorClassAt('name')"
          :message="errors.get('name')")
    b-input(type="text"
            placeholder="e.g. 居家用品"
            v-model="form.name"
            data-behavior="product-category-name-field"
            @input="errors.clear('name')")

  b-field(:label="attributeLocaleText('product_category', 'description')"
          :type="errors.errorClassAt('description')"
          :message="errors.get('description')")
    b-input(type="textarea"
            :placeholder="messageLocaleText('this_column_is_optional')"
            v-model="form.description"
            data-behavior="product-category-description-field"
            @input="errors.clear('description')")



  br

  .is-pulled-right
    .button.is-primary(@click="submitForm"
                       data-behavior="submit-button"
                       :class="isLoadingClass") {{actionLocaleText('admin', 'submit')}}

</template>

<script>
import Form from '../../../../shared/forms/form_base'
import ProductCategory from '../../../../shared/resource_models/product_category'

export default {
  // components: {},

  // mixins: [],

  props: {
    parentId: {
      type: String,
      default: null
    }
  },

  data() {
    return {
      form: new Form(new ProductCategory({ parent_id: this.parentId }))
    }
  },

  computed: {
    errors() {
      return this.$store.getters['productCategories/errors']
    },

    isLoading() {
      return this.$store.getters['productCategories/isLoading']
    },

    isLoadingClass() {
      return this.isLoading ? 'is-loading' : ''
    }
  },

  // created() {},

  // mounted() {},

  methods: {
    submitForm() {
      this.$store.dispatch('productCategories/addResource', this.form.sync()).then(() => {
        this.$store.dispatch('addFlashMessage', [
          'success',
          this.messageLocaleText('resource_added_successfully', {
            resource: this.modelNameLocaleText('product_category')
          })
        ])
        this.$parent.close()
        this.$emit('product-category-added')
      })
    }
  }
}
</script>
