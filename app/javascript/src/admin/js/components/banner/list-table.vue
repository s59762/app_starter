<template lang="pug">

.vc-banner-list-table
  section
    b-tabs(type="is-boxed"
           v-model="currentFilter"
           @change="filterOnChangeHandler")
      b-tab-item(v-for="(filter, index) in availableFilters"
                 :label="enumLocaleText('banner', 'use_type', availableFilters[index])"
                 :key="index")

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
                     :label="attributeLocaleText('banner', 'position')"
                     numbric)
        | {{ props.row.position }}

      b-table-column(field="image"
                     :label="attributeLocaleText('banner', 'image')")
        .thumb-wrapper
          img.thumb(:src="props.row.image.thumb.url")

      b-table-column.options(:label="actionLocaleText('admin', 'options')"
                             numeric)
        edit-button(:banner="props.row")
        delete-button(:banner="props.row")

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
import EditButton from './edit-button.vue'
import DeleteButton from './delete-button.vue'

export default {
  components: {
    EditButton,
    DeleteButton
  },

  mixins: [backendPaginateFilterSortAndSearchableMixin],
  // props: {},
  data() {
    return {
      resourceType: 'banners',
      sortOrder: 'asc',
      sortField: 'position',
      currentFilter: 0,
      availableFilters: ['homepage', 'products', 'brands', 'sign_up']
    }
  },

  computed: {
    banners() {
      return this.$store.getters['banners/allByType'](this.availableFilters[this.currentFilter])
    }
  },

  created() {
    this.fetchingInitialData()
  }
  // mounted() {},
  // methods: {}
}
</script>
