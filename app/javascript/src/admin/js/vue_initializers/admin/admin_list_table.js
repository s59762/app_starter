import NewAdminForm from '../../components/admin/new-form'
import AdminListTable from '../../components/admin/list-table'
import backendPaginateFilterSortAndSearchableMixin from '../../components/mixins/backend_paginate_filter_sort_and_searchable_mixin'

export default {
  components: {
    NewAdminForm,
    AdminListTable
  },

  mixins: [backendPaginateFilterSortAndSearchableMixin],

  // props: {},

  data() {
    return {
      isUsingCreatedHook: false,
      resourceType: 'admins',
      currentUrlPath: '/admin/admins/',
      isNewAdminFormActive: false
    }
  },

  // mounted() {},

  methods: {
    showNewAdminForm() {
      this.isNewAdminFormActive = true
    },

    reloadAdminListTable() {
      let options = this.checkCurrentQueryStringOptionsFromURL()

      this.fetchData(options)
    }
  }
}
