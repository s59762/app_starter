<template lang="pug">

.vc-product-category-list-table
  b-table(:data="rootCategories"
          backend-sorting
          :default-sort="sortField"
          :default-sort-direction="sortOrder"
          @sort="onSort"
          :total="totalCount"
          :loading="isLoading"
          :hoverable="true"
          detailed
          detail-key="id"
          data-behavior="product-category-list")

    template(slot-scope="props")

      b-table-column(field="name"
                    :label="attributeLocaleText('product_category', 'name')"
                    sortable)
        a(:href="productCategoryPath(props.row)")
          .icon
            i.fa.fa-search
          span {{ props.row.name }}

      b-table-column(field="parent_id"
                     :label="attributeLocaleText('product_category', 'has_sub_categories')"
                     centered)
        i.sub-categories-indicator.fa(:class="hasSubCategories(props.row)")

      b-table-column(field="products_count"
                     :label="attributeLocaleText('product_category', 'products_count')"
                     centered)
        | {{ calculateTopLevelCategoryProductsCount(props.row) }}

      b-table-column.options(:label="actionLocaleText('admin', 'options')"
                             numeric)
        new-sub-category-button(:parent="props.row"
                                @product-category-added="categoryAddedHandler")
        edit-button(:category="props.row")

    template(slot="detail"
             slot-scope="props")

      sub-categories-table(:parent="props.row")

    template(slot='empty')
      section.section
        .content.has-text-grey.has-text-centered
          p
            b-icon(icon='times'
                  size='is-large')
          p {{messageLocaleText('there_is_no_data_for_now')}}

</template>

<script>
import EditButton from './edit-button'
import SubCategoriesTable from './sub-categories-table'
import NewSubCategoryButton from './new-sub-category-button'
import backendPaginateFilterSortAndSearchableMixin from '../../components/mixins/backend_paginate_filter_sort_and_searchable_mixin'

export default {
  components: {
    EditButton,
    SubCategoriesTable,
    NewSubCategoryButton
  },

  mixins: [backendPaginateFilterSortAndSearchableMixin],

  // props: {},

  data() {
    return {
      resourceType: 'productCategories',
      currentPage: null,
      pageSize: null,
      sortOrder: 'asc',
      sortField: 'id',
      availableFilters: ['']
    }
  },

  computed: {
    categories() {
      return this.$store.getters['productCategories/all']
    },

    // 最上層的 ProductCategory
    rootCategories() {
      return this.categories.filter(element => Object.keys(element.parent).length === 0)
    }
  },

  created() {
    this.fetchingInitialData()
  },

  // mounted() {},

  methods: {
    hasSubCategories(parent) {
      if (parent.sub_categories.length > 0) {
        return 'fa-check-circle'
      } else {
        return ''
      }
    },

    categoryAddedHandler() {
      this.$emit('product-category-added')
    },

    calculateTopLevelCategoryProductsCount(topLevelCategory) {
      const subCategoryIds = topLevelCategory.sub_categories.map(sub_category => sub_category.id)
      return this.categories
        .filter(category => subCategoryIds.includes(category.id))
        .reduce((accumulator, currentCategory) => {
          return accumulator + currentCategory.products_count
        }, topLevelCategory.products_count)
    },

    productCategoryPath(productCategory) {
      return `/admin/product_categories/${productCategory.id}`
    }
  }
}
</script>
