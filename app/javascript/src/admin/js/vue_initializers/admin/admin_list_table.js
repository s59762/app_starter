import NewAdminForm from '../../components/admin/new-form'
import AdminListTable from '../../components/admin/list-table'

export default {
  components: {
    NewAdminForm,
    AdminListTable
  },

  // mixins: [],

  // props: {},

  data() {
    return {
      isNewAdminFormActive: false
    }
  },

  // mounted() {},

  methods: {
    showNewAdminForm() {
      this.isNewAdminFormActive = true
    }
  }
}
