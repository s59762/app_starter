<template lang="pug">

.vc-product-description-column
  b-field(:label="attributeLocaleText('product', 'description')"
          :type="errors.errorClassAt('description')"
          :message="errors.get('description')")
    quill-editor(v-model="form.description"
                 ref="quill"
                 data-behavior="product-description"
                 :options="editorOptions")

</template>

<script>
import quillEditorMixin from '../mixins/quill_editor_mixin.js'

export default {
  // components: {},

  mixins: [quillEditorMixin],

  props: {
    errors: {
      type: Object,
      required: true
    },

    form: {
      type: Object,
      required: true
    },

    uploadAction: {
      type: String,
      required: false,
      default: () => {
        return 'products/uploadAttachments'
      }
    }
  },

  // data() {
  //   return {}
  // },
  // computed: {},
  // created() {},
  // mounted() {},
  methods: {
    /*
    * Quill 的 module ImageHandler 和 imageButtonHandler 在上傳照片之後，可接受一個 Callback
    * 這邊把上傳後的圖片 ID 記錄下來，一併在儲存 product 時送給後端做後續處理。
    */
    imageUploadedCallback(image) {
      this.form.uploaded_attachment_ids.push(parseInt(image.id))
    }
  }
}
</script>
