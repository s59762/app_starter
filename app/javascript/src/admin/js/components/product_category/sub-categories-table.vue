<template lang="pug">


b-table.vc-product-category-sub-categories-table(:data="subCategories"
                                                 :hoverable="true")
  template(slot-scope="props"
           slot="header")

  template(slot-scope="props")

    b-table-column(field="name"
                   :label="attributeLocaleText('product_category', 'sub_category_name')")
      a(:href="productSubCategoryPath(props.row)")
          .icon
            i.fa.fa-search
          span {{ props.row.name }}

    b-table-column(field="products_count"
                   :label="attributeLocaleText('product_category', 'products_count')")
      | {{ props.row.products_count }}

    b-table-column.options(:label="actionLocaleText('admin', 'options')"
                           width="50")
      edit-button(:category="props.row")

  template(slot='empty')
    .content.has-text-grey.has-text-centered
      p {{ messageLocaleText('there_is_no_sub_categories_for_now') }}

</template>

<script>
import EditButton from './edit-button'

export default {
  components: {
    EditButton
  },

  // mixins: [],

  props: {
    parent: {
      type: Object,
      required: true
    }
  },

  // data() {
  //   return {}
  // },

  computed: {
    categories() {
      return this.$store.getters['productCategories/all']
    },

    subCategories() {
      const nextLevelCategoriesID = this.parent.sub_categories.map(element => element.id)

      return nextLevelCategoriesID.map(id => this.categories.find(element => element.id == id))
    }
  },

  // created() {},

  // mounted() {},

  methods: {
    productSubCategoryPath(productCategory) {
      return `/admin/product_categories/${productCategory.parent_id}/sub_categories/${productCategory.id}`
    }
  }
}
</script>
