<template lang="pug">

.box.form-container-box.is-default.clearfix
  h3.subtitle {{pageTitleLocaleText('admin', 'admins', 'edit')}}

  //- change password fields
  b-collapse.panel(:open.sync="isEditPasswordInputOpen")
    .panel-heading(slot="trigger") {{actionLocaleText('admin', 'change_password')}}
    .panel-block
      b-field(:label="attributeLocaleText('admin', 'password')"
              :type="form.errorClassAt('password')"
              :message="form.errors.get('password')")
        b-input(type="password"
                :placeholder="actionLocaleText('admin', 'if_do_not_want_to_change_password_leave_empty')"
                v-model="form.password"
                @input="form.errors.clear('password')")

      b-field(:label="attributeLocaleText('admin', 'password_confirmation')"
              :placeholder="actionLocaleText('admin', 'if_do_not_want_to_change_password_leave_empty')"
              :type="form.errorClassAt('password_confirmation')"
              :message="form.errors.get('password_confirmation')")
        b-input(type="password"
                v-model="form.password_confirmation"
                @input="form.errors.clear('password_confirmation')")

  //- general fields
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
  props: {
    admin: {
      type: Object,
      required: true
    }
  },

  data() {
    return {
      form: new Form(
        {
          password: '',
          password_confirmation: '',
          name: this.admin.name,
          role: this.admin.role
        },
        this.$store.dispatch,
        this.$store.getters['admins/errors']
      ),
      isEditPasswordInputOpen: false
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

  // created() {},
  mounted() {
    if (this.availableRoles) {
      this.form.role = this.availableRoles[0]
    } else {
      this.fetchAvailableRolesAndSetDefaultSelect()
    }
  },

  methods: {
    fetchAvailableRolesAndSetDefaultSelect() {
      this.$store.dispatch('admins/fetchAvailableRoles').then(response => {
        this.form.role = response.data.data[0]
      })
    },

    submitForm() {
      console.log(this.requestBody)
    }
  }
}
</script>
