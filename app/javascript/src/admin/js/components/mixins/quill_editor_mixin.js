import Cookies from 'js-cookie'
import { quillEditor, Quill } from 'vue-quill-editor'
import ImageHandler from '../../../../shared/plugins/quill_image_handler_module/image_handler'

const toolbarOptions = [
  [{ size: [false, 'small', 'large', 'huge'] }], // custom dropdown
  [{ header: [false, 1, 2, 3] }],
  ['bold', 'italic', 'underline', 'strike'], // toggled buttons
  [{ align: [] }],
  ['blockquote', 'code-block'],
  [{ list: 'ordered' }, { list: 'bullet' }],
  [{ indent: '-1' }, { indent: '+1' }], // outdent/indent
  [{ color: [] }, { background: [] }], // dropdown with defaults from theme
  ['clean']
]

Quill.register('modules/ImageHandler', ImageHandler)

export default {
  components: {
    quillEditor
  },
  // props: {},
  data() {
    return {
      editorOptions: {
        placeholder: 'e.g. A powerfull tool for your professional works.',
        modules: {
          toolbar: {
            container: toolbarOptions
          },
          ImageHandler: true
        }
      }
    }
  }
  // computed: {},
  // methods: {}
}
