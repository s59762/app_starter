<template lang="pug">

.vc-product-list-table
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

      b-table-column(field="id"
                     label="ID"
                     sortable
                     numbric)
        | {{props.row.id}}

      b-table-column(field="name"
                     :label="attributeLocaleText('product', 'name')"
                     sortable)
        | {{props.row.name}}

      b-table-column(field="original_price"
                     :label="attributeLocaleText('product', 'original_price')"
                     sortable
                     numbric)
        | {{props.row.displayPrice('original')}}

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

      b-table-column.preorder-column(field="is_preorder"
                                     :label="attributeLocaleText('product', 'is_preorder')"
                                     sortable
                                     numbric)
        span.tag.is-default
          i.fa(:class="preorderIcon(props.row)")

      b-table-column(:label="actionLocaleText('admin', 'options')"
                    numeric)
          //- Edit button
          button.button.is-small.is-info(@click="linkToEditPage(props.row)")
            .icon
              i.fa.fa-pencil
            span 編輯

    template(slot='empty')
      section.section
        .content.has-text-grey.has-text-centered
          p
            b-icon(icon='times'
                   size='is-large')
          p {{messageLocaleText('there_is_no_data_for_now')}}

</template>

<script>
import backendPaginateFilterSortAndSearchableMixin from '../mixins/backend_paginate_filter_sort_and_searchable_mixin'

export default {
  // components: {},

  mixins: [backendPaginateFilterSortAndSearchableMixin],

  // props: {},

  data() {
    return {
      resourceType: 'products',
      currentUrlPath: '/admin/products',
      availableFilters: ['']
    }
  },

  computed: {
    products() {
      return this.$store.getters['products/all']
    }
  },

  created() {
    this.fetchingInitialData()
  },

  // mounted() {},

  methods: {
    preorderIcon(product) {
      if (product.is_preorder) {
        return 'fa-check-circle'
      } else {
        return 'fa-times-circle'
      }
    },

    linkToEditPage(product) {
      Turbolinks.visit(`/admin/products/${product.id}/edit`)
    }
  }
}
</script>
