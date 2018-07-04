<template lang="pug">

.vc-product-image-edit-form.box.form-container-box.is-default.clearfix
  h3.subtitle {{ pageTitleLocaleText('admin', 'products', 'image_config') }}

  //- Button for set as cover

  //- Button for assign to variant

  br

  .is-pulled-right
    .button.is-primary(@click="submitForm"
                       :class="{'is-loading': isLoading}") {{ actionLocaleText('admin', 'submit') }}

</template>

<script>
export default {
  // components: {},
  // mixins: [],
  props: {
    image: {
      type: Object,
      required: true
    }
  },

  data() {
    return {}
  },

  computed: {
    isLoading() {
      return this.$store.getters['productImages/isLoading']
    },

    errors() {
      return this.image.errors
    }
  },
  // created() {},
  // mounted() {},
  methods: {
    submitForm() {
      console.log('ok')
    }
  }
}
</script>
