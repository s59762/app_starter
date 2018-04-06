<template lang="pug">

.box.form-container-box.is-default.clearfix
  h3.subtitle {{pageTitleLocaleText('admin', 'admins', 'edit')}}

  //- change password fields
  b-collapse.panel(:open.sync="isEditPasswordInputOpen")
    .panel-heading(slot="trigger") {{actionLocaleText('admin', 'change_password')}}
    .panel-block
      b-field(:label="attributeLocaleText('admin', 'new_password')"
              :type="errors.errorClassAt('new_password')"
              :message="errors.get('new_password')")
        b-input(type="password"
                v-model="form.new_password"
                :placeholder="messageLocaleText('help.if_do_not_want_to_change_password_leave_empty')"
                data-behavior="admin-password"
                @input="errors.clear('new_password')")

      b-field(:label="attributeLocaleText('admin', 'password_confirmation')"
              :type="errors.errorClassAt('password_confirmation')"
              :message="errors.get('password_confirmation')")
        b-input(type="password"
                v-model="form.password_confirmation"
                :placeholder="messageLocaleText('help.if_do_not_want_to_change_password_leave_empty')"
                data-behavior="admin-password-confirmation"
                @input="errors.clear('password_confirmation')")

  //- general fields
  b-field(:label="attributeLocaleText('admin', 'name')"
          :type="errors.errorClassAt('name')"
          :message="errors.get('name')")
    b-input(type="text"
            placeholder="e.g. Jone Doe"
            v-model="form.name"
            data-behavior="admin-name"
            @input="errors.clear('name')")

  b-field(:label="attributeLocaleText('admin', 'role')"
          :type="errors.errorClassAt('role')"
          :message="errors.get('role')")
    b-select(v-model="form.role"
             :loading="isLoading"
             data-behavior="admin-role"
             @input="errors.clear('role')"
             expanded)
      option(v-for="role in availableRoles"
             :value="role")
        | {{enumLocaleText('admin', 'role', role)}}

  br

  .is-pulled-right
    .button.is-primary(data-behavior="submit-button"
                       @click="submitForm") {{actionLocaleText('admin', 'submit')}}

</template>

<script>
import Form from '../../../../shared/forms/form_base'

export default {
  // components: {},
  // mixins: [],
  props: {
    admin: {
      type: Object,
      required: true
    }
  },

  data() {
    return {
      form: new Form(this.admin),
      isEditPasswordInputOpen: false
    }
  },

  computed: {
    errors() {
      return this.$store.getters['admins/errors']
    },

    isLoading() {
      return this.$store.getters['admins/isLoading']
    },

    availableRoles() {
      return this.$store.getters['admins/availableRoles']
    }
  },

  // created() {},
  mounted() {
    if (!this.availableRoles) {
      this.$store.dispatch('admins/fetchAvailableRoles')
    }
  },

  methods: {
    submitForm() {
      this.$store.dispatch('admins/updateResource', this.form.sync()).then(response => {
        this.$store.dispatch('addFlashMessage', [
          'success',
          this.messageLocaleText('resource_updated_successfully', { resource: this.modelNameLocaleText('admin') })
        ])
        this.$parent.close()
      })
    }
  }
}
</script>
