import Cookies from 'js-cookie'
import { quillEditor, Quill } from 'vue-quill-editor'

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
            container: toolbarOptions,
            handlers: {
              image: function() {
                QuillWatch.emit(this.quill.id)
              }
            }
          }
        }
      }
    }
  }
  // computed: {},
  // methods: {}
}
