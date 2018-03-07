import backendPaginateAndFilterAndSortableMixin from '../../components/mixins/backend_paginate_and_filter_and_sortable_mixin'
import UserListTable from '../../components/user/list-table'

export default {
  components: {
    UserListTable
  },

  mixins: [backendPaginateAndFilterAndSortableMixin],

  // props: {},

  data() {
    return {
      isUsingCreatedHook: true,
      resourceType: 'users',
      currentUrlPath: '/admin/users/',
      isNewAdminFormActive: false
    }
  },

  computed: {
    users() {
      return this.$store.getters['users/allResources']
    }
  }

  // created() {},

  // mounted() {},

  // methods: {}
}
