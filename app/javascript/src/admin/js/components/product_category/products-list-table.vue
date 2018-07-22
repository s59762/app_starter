<template lang="pug">

.vc-product-category-products-list-table
  b-table(:data="products"
          paginated
          backend-pagination
          :currentPage="currentPage"
          :perPage="pageSize"
          @page-change="onPageChange"
          backend-sorting
          :default-sort="sortField"
          :default-sort-direction="sortOrder"
          @sort="onSort"
          :total="totalCount"
          :loading="isLoading"
          :hoverable="true")

    template(slot-scope="props")

      b-table-column(field="product_variants.sku"
                     label="SKU"
                     sortable)
        | {{props.row.sku}}

      b-table-column(field="products.name"
                     :label="attributeLocaleText('product', 'name')"
                     sortable)
        | {{props.row.name}}

      b-table-column(field="sell_price"
                     :label="attributeLocaleText('product', 'sell_price')"
                     sortable
                     numbric)
        | {{props.row.displayPrice('sell')}}

      b-table-column(field="discounted_price"
                     :label="attributeLocaleText('product', 'discounted_price')"
                     sortable
                     numbric)
        | {{props.row.displayPrice('discounted')}}
        span(v-if="props.row.hasDiscount()") （{{props.row.displayDiscountRate()}}）

      b-table-column.options(:label="actionLocaleText('admin', 'options')"
                             numeric)
          //- Edit button
          button.button.is-small.is-info(@click="linkToEditPage(props.row)")
            .icon
              i.fa.fa-pencil
            span {{ actionLocaleText('admin', 'edit') }}

    template(slot='empty')
      section.section
        .content.has-text-grey.has-text-centered
          p
            b-icon(icon='times'
                   size='is-large')
          p {{ messageLocaleText('there_is_no_data_for_now') }}

</template>

<script>
import backendPaginateFilterSortAndSearchableMixin from '../mixins/backend_paginate_filter_sort_and_searchable_mixin'

export default {
  // components: {},
  mixins: [backendPaginateFilterSortAndSearchableMixin],

  props: {
    productCategory: {
      type: Object,
      required: true
    }
  },

  data() {
    return {
      resourceType: 'products',
      sortField: 'products.created_at'
    }
  },

  computed: {
    isLoading() {
      return this.$store.getters['productCategories/isLoading']
    },

    products() {
      return this.$store.getters['products/all']
    }
  },

  created() {
    this.fetchingInitialData()
  },
  // mounted() {},
  methods: {
    fetchData(options) {
      this.currentPage = options.pageNumber
      this.$store.dispatch('productCategories/fetchProducts', {
        model: this.productCategory,
        options
      })
    },

    linkToEditPage(product) {
      Turbolinks.visit(`/admin/products/${product.id}/edit`)
    }
  }
}
</script>
