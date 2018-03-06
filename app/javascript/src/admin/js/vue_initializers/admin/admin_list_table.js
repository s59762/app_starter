import NewAdminForm from '../../components/admin/new-form'
import AdminListTable from '../../components/admin/list-table'
import backendPaginateAndFilterAndSortableMixin from '../../components/mixins/backend_paginate_and_filter_and_sortable_mixin'

export default {
  components: {
    NewAdminForm,
    AdminListTable
  },

  mixins: [backendPaginateAndFilterAndSortableMixin],

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
