<template lang="pug">

.vc-product-category-selector.columns
  .column
    //- 主分類
    b-field(:label="attributeLocaleText('product', 'category_id')"
            :type="errors.errorClassAt('top_level_category_id')"
            :message="errors.get('top_level_category_id')"
            class="required")
      b-select(v-model="form.top_level_category_id"
              :loading="isLoading"
              :placeholder="messageLocaleText('help.please_select_a_category')"
              @input="topLevelCategoryUpdateHandler"
              expanded)
        option(v-for="topLevelCategory in topLevelCategories"
              :label="topLevelCategory.name"
              :value="topLevelCategory.id"
              :key="topLevelCategory.id")
          | {{ topLevelCategory.name }}
  .column(v-if="findCategoryBy(form.top_level_category_id)")
    //- 子分類
    b-field(:label="attributeLocaleText('product', 'sub_category')"
            :type="errors.errorClassAt('sub_category_id')"
            :message="errors.get('sub_category_id')")
      b-select(v-model="form.sub_category_id"
              :loading="isLoading"
              :placeholder="messageLocaleText('help.no_sub_category')"
              @input="errors.clear('sub_category_id')"
              expanded)
        option(:label="messageLocaleText('help.no_sub_category')"
              :value="undefined")
        option(v-for="subCategory in findCategoryBy(form.top_level_category_id).sub_categories"
              :label="findCategoryBy(subCategory.id).name"
              :value="subCategory.id"
              :key="subCategory.id")
          | {{ findCategoryBy(subCategory.id).name }}

</template>

<script>
export default {
  // components: {},
  // mixins: [],
  props: {
    errors: {
      type: Object,
      required: true
    },

    form: {
      type: Object,
      required: true
    }
  },
  // data() {
  //   return {}
  // },
  computed: {
    isLoading() {
      return this.$store.getters['productCategories/isLoading']
    },

    categories() {
      return this.$store.getters['productCategories/all']
    },

    topLevelCategories() {
      return this.categories.filter(category => category.parent_id === null)
    }
  },

  created() {
    this.$store.dispatch('productCategories/all')
  },
  // mounted() {},
  methods: {
    findCategoryBy(id) {
      return this.categories.find(category => category.id == id)
    },

    topLevelCategoryUpdateHandler() {
      this.errors.clear('top_level_category_id')
      this.form.sub_category_id = null
    }
  }
}
</script>
