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

  computed: {
    admins() {
      return this.$store.getters['admins/allResources']
    }
  },

  created() {
    this.$store.dispatch('admins/fetchAllResources')
  },

  // mounted() {},

  methods: {
    showNewAdminForm() {
      this.isNewAdminFormActive = true
    }
  }
}
