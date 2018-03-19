<template lang="pug">

.box.form-container-box.is-default.clearfix
  h3.subtitle {{pageTitleLocaleText('admin', 'admins', 'new')}}

  b-field(:label="attributeLocaleText('admin', 'email')"
          :type="form.errorClassAt('email')"
          :message="form.errors.get('email')")
    b-input(type="text"
            placeholder="e.g. name@example.com"
            v-model="form.email"
            @input="form.errors.clear('email')")

  b-field(:label="attributeLocaleText('admin', 'password')"
          :type="form.errorClassAt('password')"
          :message="form.errors.get('password')")
    b-input(type="password"
            :placeholder="messageLocaleText('help.leave_empty_for_default_password')"
            v-model="form.password"
            @input="form.errors.clear('password')")
  b-field(:label="attributeLocaleText('admin', 'password_confirmation')"
          :type="form.errorClassAt('password_confirmation')"
          :message="form.errors.get('password_confirmation')")
    b-input(type="password"
            :placeholder="messageLocaleText('help.please_re_enter_password_for_confirmation')"
            v-model="form.password_confirmation"
            @input="form.errors.clear('password_confirmation')")

  b-field(:label="attributeLocaleText('admin', 'name')"
          :type="form.errorClassAt('name')"
          :message="form.errors.get('name')")
    b-input(type="text"
            placeholder="e.g. Jone Doe"
            v-model="form.name"
            @input="form.errors.clear('name')")

  b-field(:label="attributeLocaleText('admin', 'role')"
          :type="form.errorClassAt('role')"
          :message="form.errors.get('role')")
    b-select(v-model="form.role"
             :loading="isLoading"
             @input="form.errors.clear('role')"
             expanded)
      option(v-for="role in availableRoles"
             :value="role")
        | {{enumLocaleText('admin', 'role', role)}}

  br

  .is-pulled-right
    .button.is-primary(@click="submitForm") {{actionLocaleText('admin', 'submit')}}

</template>

<script>
import Form from '../../../../shared/form'

export default {
  // components: {},
  // mixins: [],
  // props: {},
  data() {
    return {
      form: new Form(
        {
          email: '',
          password: '',
          password_confirmation: '',
          name: '',
          role: ''
        },
        this.$store.dispatch,
        this.$store.getters['admins/errors']
      )
    }
  },

  computed: {
    isLoading() {
      return this.$store.getters['admins/isLoading']
    },

    availableRoles() {
      return this.$store.getters['admins/availableRoles']
    },

    requestBody() {
      return {
        data: {
          type: 'admins',
          attributes: this.form.data()
        }
      }
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
      this.form.dispatch('admins/addResource', this.requestBody).then(() => {
        this.form.addFlashMessage(['success', this.messageLocaleText('admin_added_successfully')])
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
