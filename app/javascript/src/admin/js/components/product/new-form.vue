<template lang="pug">

.product-new-form.box.content-box.is-primary
  .box-header.with-border
    h3.subtitle {{pageTitleLocaleText('admin', 'products', 'form')}}
  .box-body
    .columns
      //- input fields
      .column.is-7
        b-loading(:active.sync="isLoading"
                  :is-full-page="false")

        //- basic info
        section.section.basic-info-wrapper
          b-field(:label="attributeLocaleText('product', 'name')"
                  :type="errors.errorClassAt('name')"
                  :message="errors.get('name')")
            b-input(type="text"
                    placeholder="e.g. iMac Pro 3.8GHz"
                    v-model="form.name"
                    @input="errors.clear('name')")

          b-field(:label="attributeLocaleText('product', 'description')"
                  :type="errors.errorClassAt('description')"
                  :message="errors.get('description')")
            quill-editor(v-model="form.description"
                         ref="quill"
                         :options="editorOptions")

        //- price info
        section.section.price-info-wrapper
          .columns
            .column
              b-field(:label="attributeLocaleText('product', 'original_price')"
                      :type="errors.errorClassAt('price')"
                      :message="errors.get('price')")
                b-input(type="number"
                        placeholder="e.g. 80000"
                        v-model="form.price.original"
                        @input="errors.clear('price')")
            .column
              b-field(:label="attributeLocaleText('product', 'sell_price')"
                      :type="errors.errorClassAt('price')"
                      :message="errors.get('price')")
                b-input(type="number"
                        placeholder="e.g. 100000"
                        v-model="form.price.sell"
                        @input="errors.clear('price')")
            .column
              b-field(:label="attributeLocaleText('product', 'discounted_price')"
                      :type="errors.errorClassAt('price')"
                      :message="errors.get('price')")
                b-input(type="number"
                        placeholder="e.g. 98000"
                        v-model="form.price.discounted"
                        @input="errors.clear('price')")

        //- options
        section.section.product-options-wrapper
          b-field(:label="attributeLocaleText('product', 'is_preorder')"
                  :type="errors.errorClassAt('is_preorder')"
                  :message="errors.get('is_preorder')")
            b-switch(v-model="form.is_preorder"
                      type="is-success"
                      @input="errors.clear('is_preorder')")
              | {{enumLocaleText('product', 'is_preorder', form.is_preorder)}}

        //- properties
        section.section
          h4.section-title {{pageTitleLocaleText('admin', 'products', 'property_fields')}}
          .properties-wrapper
            .property-fields(v-for="(property, index) in form.properties")
              .property-count {{index + 1}}
              .delete-button(@click="deleteProperty(index)")
                i.fa.fa-close
              .columns
                .column
                  b-field(:label="attributeLocaleText('product', 'property_name')"
                          :type="errors.errorClassAt('properties')"
                          :message="errors.get('properties')")
                    b-input(type="text"
                            placeholder="e.g. Weight"
                            v-model="property.name"
                            @input="errors.clear('properties')")
                .column.is-6
                  b-field(:label="attributeLocaleText('product', 'property_value')"
                          :type="errors.errorClassAt('properties')"
                          :message="errors.get('properties')")
                    b-input(type="text"
                            placeholder="e.g. 12"
                            v-model="property.value"
                            @input="errors.clear('properties')")
                .column
                  b-field(:label="attributeLocaleText('product', 'property_unit')"
                          :type="errors.errorClassAt('properties')"
                          :message="errors.get('properties')")
                    b-input(type="text"
                            placeholder="e.g. kg"
                            v-model="property.unit"
                            @input="errors.clear('properties')")

          .add-property-button.button.is-default.is-block(@click="addProperty")
            .icon
              i.fa.fa-plus
            span {{actionLocaleText('admin', 'add_product_property')}}

        br

        .is-pulled-right
        .button.is-primary(@click="submitForm") {{actionLocaleText('admin', 'submit')}}
      //- previews
      .column
        //- TODO: create a component for roughly preview input content
        //- product-previewer(:product="this.form")

</template>

<script>
import { quillEditor, Quill } from 'vue-quill-editor'
import ImageHandler from '../../../../shared/plugins/quill_image_handler_module/image_handler'
import imageButtonHandler from '../../../../shared/plugins/quill_image_handler_module/image_button_handler'
import Product from '../../../../shared/resource_models/product'
import Form from '../../../../shared/forms/form_base'

const toolbarOptions = [
  [{ size: [false, 'small', 'large', 'huge'] }], // custom dropdown
  [{ header: [false, 1, 2, 3] }],
  ['bold', 'italic', 'underline', 'strike'], // toggled buttons
  [{ align: [] }],
  ['blockquote', 'code-block'],
  [{ list: 'ordered' }, { list: 'bullet' }],
  [{ indent: '-1' }, { indent: '+1' }], // outdent/indent
  [{ color: [] }, { background: [] }], // dropdown with defaults from theme
  ['image', 'clean']
]

const imagesAttrName = 'product[images][]'
const createAction = 'products/uploadImages'
const deleteAction = 'products/deleteImage'
const additionalFormData = formData => {
  formData.append('product[use_case]', 'description')
}

const propertyTemplate = function() {
  return {
    name: '',
    value: '',
    unit: ''
  }
}

Quill.register('modules/ImageHandler', ImageHandler)

export default {
  components: {
    quillEditor
  },

  // mixins: [],

  // props: {},

  data() {
    return {
      form: new Form(new Product()),
      editorOptions: {
        placeholder: 'e.g. A powerfull tool for your professional works.',
        modules: {
          ImageHandler: {
            dispatcher: this.$store.dispatch,
            createAction: createAction,
            deleteAction: deleteAction,
            imagesAttrName: imagesAttrName,
            additionalFormData: additionalFormData
          },
          toolbar: {
            container: toolbarOptions,
            handlers: {
              image: () => {
                imageButtonHandler({
                  imagesAttrName,
                  additionalFormData,
                  dispatcher: this.$store.dispatch,
                  action: createAction,
                  quill: this.$refs.quill.quill
                })
              }
            }
          }
        }
      }
    }
  },

  computed: {
    errors() {
      return this.$store.getters['products/errors']
    },

    isLoading() {
      return this.$store.getters['products/isLoading']
    }
  },

  created() {
    this.form.properties = [propertyTemplate()]
    this.form.image_ids = []
    this.form.price = {
      original: 0,
      sell: 0,
      discounted: 0
    }
  },

  // mounted() {},

  methods: {
    addProperty() {
      this.form.properties.push(propertyTemplate())
    },

    deleteProperty(index) {
      this.form.properties.splice(index, 1)
    },

    submitForm() {
      this.$store.dispatch('products/create', this.form.sync()).then(() => {
        Turbolinks.visit('/admin/products?product_added=1')
      })
    }
  }
}
</script>
