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
        | {{props.row.name}}

      b-table-column(field="name"
                     :label="attributeLocaleText('product_category', 'has_sub_categories')"
                     centered)
        i.sub-categories-indicator.fa(:class="hasSubCategories(props.row)")

      b-table-column(:label="actionLocaleText('admin', 'options')"
                     numeric)
        new-sub-category-button(:parent="props.row"
                                @product-category-added="categoryAddedHandler")
        | &nbsp;
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
      currentUrlPath: '/admin/product_categories',
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
    }
  }
}
</script>
