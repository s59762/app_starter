<template lang="pug">

.product-category-new-form.box.form-container-box.is-default.clearfix
  h3.subtitle {{pageTitleLocaleText('admin', 'product_categories', 'new')}}

  b-field(:label="attributeLocaleText('product_category', 'name')"
          :type="form.errorClassAt('name')"
          :message="form.errors.get('name')")
    b-input(type="text"
            placeholder="e.g. 居家用品"
            v-model="form.name"
            @input="form.errors.clear('name')")

  b-field(:label="attributeLocaleText('product_category', 'description')"
          :type="form.errorClassAt('description')"
          :message="form.errors.get('description')")
    b-input(type="textarea"
            :placeholder="messageLocaleText('this_column_is_optional')"
            v-model="form.description"
            @input="form.errors.clear('description')")



  br

  .is-pulled-right
    .button.is-primary(@click="submitForm"
                       :class="isLoadingClass") {{actionLocaleText('admin', 'submit')}}

</template>

<script>
import Form from '../../../../shared/form'

export default {
  // components: {},

  // mixins: [],

  // props: {},

  data() {
    return {
      form: new Form(
        {
          name: '',
          description: ''
        },
        this.$store.dispatch,
        this.$store.getters['productCategories/errors']
      )
    }
  },

  computed: {
    isLoading() {
      return this.$store.getters['productCategories/isLoading']
    },

    isLoadingClass() {
      return this.isLoading ? 'is-loading' : ''
    },

    requestBody() {
      return {
        data: {
          type: 'product_categories',
          attributes: this.form.data()
        }
      }
    }
  },

  // created() {},

  // mounted() {},

  methods: {
    submitForm() {
      this.form.dispatch('productCategories/addResource', this.requestBody).then(() => {
        this.form.dispatch('addFlashMessage', [
          'success',
          this.messageLocaleText('resource_added_successfully', {
            resource: this.modelNameLocaleText('product_category')
          })
        ])
        this.$parent.close()
      })
    }
  }
}
</script>
