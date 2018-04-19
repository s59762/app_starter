<template lang="pug">

.box.form-container-box.is-default.clearfix
  h3.subtitle {{pageTitleLocaleText('admin', 'admins', 'new')}}

  b-field(:label="attributeLocaleText('admin', 'email')"
          :type="errors.errorClassAt('email')"
          :message="errors.get('email')")
    b-input(type="text"
            placeholder="e.g. name@example.com"
            v-model="form.email"
            data-behavior="admin-email"
            @input="errors.clear('email')")

  b-field(:label="attributeLocaleText('admin', 'password')"
          :type="errors.errorClassAt('password')"
          :message="errors.get('password')")
    b-input(type="password"
            :placeholder="messageLocaleText('help.leave_empty_for_default_password')"
            v-model="form.password"
            data-behavior="admin-password"
            @input="errors.clear('password')")
  b-field(:label="attributeLocaleText('admin', 'password_confirmation')"
          :type="errors.errorClassAt('password_confirmation')"
          :message="errors.get('password_confirmation')")
    b-input(type="password"
            :placeholder="messageLocaleText('help.please_re_enter_password_for_confirmation')"
            v-model="form.password_confirmation"
            data-behavior="admin-password-confirmation"
            @input="errors.clear('password_confirmation')")

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
    button.button.is-primary(@click="submitForm"
                             data-behavior="submit-button") {{actionLocaleText('admin', 'submit')}}

</template>

<script>
import Form from '../../../../shared/forms/form_base'
import Admin from '../../../../shared/resource_models/admin'

export default {
  // components: {},
  // mixins: [],
  // props: {},
  data() {
    return {
      form: new Form(new Admin())
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

  mounted() {
    if (this.availableRoles) {
      this.form.role = this.availableRoles[0]
    } else {
      this.fetchAvailableRolesAndSetDefaultSelect()
    }
  },

  methods: {
    submitForm() {
      this.$store.dispatch('admins/save', this.form.sync()).then(() => {
        this.$store.dispatch('addFlashMessage', [
          'success',
          this.messageLocaleText('resource_added_successfully', { resource: this.modelNameLocaleText('admin') })
        ])
        this.$parent.close()
        this.$emit('admin-added')
      })
    },

    fetchAvailableRolesAndSetDefaultSelect() {
      this.$store.dispatch('admins/fetchAvailableRoles').then(response => {
        this.form.role = response.data.data[0]
      })
    }
  }
}
</script>
