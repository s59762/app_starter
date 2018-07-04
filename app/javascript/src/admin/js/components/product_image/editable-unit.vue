<template lang="pug">

.vc-product-image-editable-unit
  .image-container
    img.image(:src="image.thumb_url")
    .edit-trigger(@click="showForm")
      .icon
        i.fa.fa-pencil
    .delete-button(@click="confirmDelete")
      i.fa.fa-close

  b-modal(:active.sync="isFormActive")

</template>

<script>
import ActionConfirmService from '../../../../shared/services/action_confirm_service.js'

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
    return {
      isFormActive: false
    }
  },
  // computed: {},
  // created() {},
  // mounted() {},
  methods: {
    showForm() {
      this.isFormActive = true
    },

    confirmDelete() {
      new ActionConfirmService({
        title: this.messageLocaleText('confirmations.are_you_sure_want_to_delete_for', {
          model: this.modelNameLocaleText('product/image')
        })
      }).confirm(this.deleteImage)
    },

    deleteImage() {
      this.$store.dispatch('productImages/destroy', this.image).then(() => {
        this.$store.dispatch('addFlashMessage', [
          'success',
          this.messageLocaleText('resource_deleted_successfully', {
            resource: this.modelNameLocaleText('product/image')
          })
        ])
      })
    }
  }
}
</script>
