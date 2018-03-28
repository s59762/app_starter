<template lang="pug">

span
  button.button.is-small.is-info(@click="openEditForm"
                                 data-behavior="edit-button")
    span.icon
      i.fa.fa-pencil
    span {{actionLocaleText('admin', 'edit')}}
  b-modal(:active.sync="isEditAdminFormActive")
    edit-admin-form.form-modal(:admin="admin")

</template>

<script>
import EditAdminForm from '../../components/admin/edit-form'

export default {
  components: {
    EditAdminForm
  },

  // mixins: [],

  props: {
    admin: {
      type: Object,
      required: true
    }
  },

  data() {
    return {
      isEditAdminFormActive: false
    }
  },

  // computed: {},

  // created() {},

  // mounted() {},

  methods: {
    openEditForm() {
      this.isEditAdminFormActive = true
    }
  }
}
</script>
