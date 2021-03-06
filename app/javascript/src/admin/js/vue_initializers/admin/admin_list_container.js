import NewAdminForm from '../../components/admin/new-form'
import AdminListTable from '../../components/admin/list-table'
import backendPaginateFilterSortAndSearchableMixin from '../../components/mixins/backend_paginate_filter_sort_and_searchable_mixin'

export default {
  name: 'admin-list-container',

  components: {
    NewAdminForm,
    AdminListTable
  },

  mixins: [backendPaginateFilterSortAndSearchableMixin],

  // props: {},

  data() {
    return {
      resourceType: 'admins',
      isNewAdminFormActive: false
    }
  },

  // mounted() {},

  methods: {
    showNewAdminForm() {
      this.isNewAdminFormActive = true
    },

    reloadAdminListTable() {
      const options = this.checkCurrentQueryStringOptionsFromURL()

      this.fetchData(options)
    }
  }
}
