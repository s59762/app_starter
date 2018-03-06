<template lang="pug">

.box.form-container-box.is-default.clearfix
  h3.subtitle {{pageTitleLocaleText('admin', 'admins', 'new')}}

  b-field(:label="attributeLocaleText('admin', 'email')"
          :type="form.errorClassAt('email')"
          :message="form.errors.get('email')")
    b-input(type="text"
            placeholder="e.g. name@example.com"
            v-model="form.email")

  b-field(:label="attributeLocaleText('admin', 'password')"
          :type="form.errorClassAt('password')"
          :message="form.errors.get('password')")
    b-input(type="text"
            :placeholder="actionLocaleText('admin', 'leave_empty_for_default_password')"
            v-model="form.password")

  b-field(:label="attributeLocaleText('admin', 'role')"
          :type="form.errorClassAt('role')"
          :message="form.errors.get('role')")
    b-select(v-model="form.role"
             :loading="isLoading"
             expanded)
      option(v-for="(role, index) in avaliableRoles"
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

    avaliableRoles() {
      return this.$store.getters['admins/avaliableRoles']
    }
  },

  mounted() {
    this.$store.dispatch('admins/fetchAvaliableRoles').then(response => {
      this.form.role = response.data.data[0]
    })
  },

  methods: {
    submitForm() {
      console.log('ok')
    }
  }
}
</script>
