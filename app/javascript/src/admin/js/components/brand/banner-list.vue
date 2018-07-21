<template lang="pug">

.vc-brand-banner-list
  b-table(:data="banners"
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

      b-table-column(field="position"
                     :label="attributeLocaleText('brand/banner', 'position')"
                     numbric)
        | {{ props.row.position }}

      b-table-column(field="image"
                     :label="attributeLocaleText('brand/banner', 'image')")
        .thumb-wrapper
          img.thumb(:src="props.row.image.thumb.url")

      b-table-column.options(:label="actionLocaleText('admin', 'options')"
                             numeric)
        brand-banner-edit-button(:brand="brand"
                                 :banner="props.row")
        brand-banner-delete-button(:banner="props.row")

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
import BrandBannerEditButton from '../brand_banner/edit-button.vue'
import BrandBannerDeleteButton from '../brand_banner/delete-button.vue'

export default {
  components: {
    BrandBannerEditButton,
    BrandBannerDeleteButton
  },

  mixins: [backendPaginateFilterSortAndSearchableMixin],

  props: {
    brand: {
      type: Object,
      required: true
    }
  },

  data() {
    return {
      resourceType: 'brandBanners',
      sortOrder: 'asc',
      sortField: 'brand_banners.position',
      availableFilters: []
    }
  },

  computed: {
    banners() {
      return this.$store.getters['brandBanners/all']
    }
  },

  created() {
    this.fetchingInitialData()
  },
  // mounted() {},
  methods: {
    fetchData(options) {
      this.currentPage = options.pageNumber
      this.$store.dispatch(`brands/fetchBanners`, {
        model: this.brand,
        options
      })
    }
  }
}
</script>
