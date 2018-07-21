import {
  quillEditor,
  Quill
} from 'vue-quill-editor'
import ImageHandler from '../../../../shared/plugins/quill_image_handler_module/image_handler'
import imageButtonHandler from '../../../../shared/plugins/quill_image_handler_module/image_button_handler'
// import ImageResize from 'quill-image-resize-module'

Quill.register('modules/ImageHandler', ImageHandler)
// Quill.register('modules/ImageResize', ImageResize)

export default {
  components: {
    quillEditor
  },

  props: {
    // 上傳圖片時，form data 中的 name 格式
    imagesAttrName: {
      type: [String, null],
      required: false,
      default: () => {
        return 'attachment[files][]'
      }
    },

    // 上傳圖片的 vuex action name
    uploadAction: {
      type: [String, null],
      required: false,
      default: () => {
        return null
      }
    },

    // form data 中若需要額外的欄位，可使用這個 callback 增加
    // e.g. `formData => { formData.append('resource[attribute]', 'value') }`
    additionalFormDataCallback: {
      type: [Function, null],
      required: false,
      default: () => {
        return null
      }
    },

    editorPlaceholder: {
      type: String,
      required: false,
      default: () => {
        return 'e.g. A powerfull tool for your professional works.'
      }
    }
  },

  data() {
    return {
      editorOptions: {
        placeholder: this.editorPlaceholder,
        modules: {
          ImageHandler: {
            dispatcher: this.$store.dispatch,
            action: this.uploadAction,
            imagesAttrName: this.imagesAttrName,
            additionalFormData: this.additionalFormDataCallback,
            imageUploadedCallback: this.imageUploadedCallback
          },
          // ImageResize: {},
          toolbar: {
            container: [
              [{
                size: [false, 'small', 'large', 'huge']
              }], // custom dropdown
              [{
                header: [false, 1, 2, 3]
              }],
              ['bold', 'italic', 'underline', 'strike'], // toggled buttons
              [{
                align: []
              }],
              ['blockquote', 'code-block'],
              [{
                list: 'ordered'
              }, {
                list: 'bullet'
              }],
              [{
                indent: '-1'
              }, {
                indent: '+1'
              }], // outdent/indent
              [{
                color: []
              }, {
                background: []
              }], // dropdown with defaults from theme
              ['image', 'video', 'clean']
            ],
            handlers: {
              image: () => {
                imageButtonHandler({
                  imagesAttrName: this.imagesAttrName,
                  additionalFormData: this.additionalFormDataCallback,
                  imageUploadedCallback: this.imageUploadedCallback,
                  dispatcher: this.$store.dispatch,
                  action: this.uploadAction,
                  quill: this.$refs.quill.quill
                })
              }
            }
          }
        }
      }
    }
  },

  // computed: {},

  methods: {
    /*
     * Quill 的 module ImageHandler 和 imageButtonHandler 在上傳照片之後，可接受一個 Callback
     *
     * @param {Object} image 圖片上傳後的 response，會是 JSON:API 格式的物件
     */
    imageUploadedCallback(image) {
      console.log(image.id)
    }
  }
}
