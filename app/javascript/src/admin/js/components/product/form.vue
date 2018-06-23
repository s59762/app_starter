<template lang="pug">

.vc-product-form.box.content-box.is-primary
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
                    data-behavior="product-name"
                    @input="errors.clear('name')")

          b-field(:label="attributeLocaleText('product', 'category_id')"
                  :type="errors.errorClassAt('category_id')"
                  :message="errors.get('category_id')")
            b-select(v-model="form.category_id"
                     :loading="isCategoriesLoading"
                     :placeholder="messageLocaleText('help.please_select_a_category')"
                     @input="errors.clear('category_id')"
                     expanded)
              optgroup(v-for="topLevelCategory in topLevelCategories"
                       :label="topLevelCategory.name"
                       :key="topLevelCategory.id")
                option(v-for="subCategory in topLevelCategory.sub_categories"
                      :value="subCategory.id"
                      :key="subCategory.id")
                  | {{ findCategoryBy(subCategory.id).name }}

          b-field(:label="attributeLocaleText('product', 'description')"
                  :type="errors.errorClassAt('description')"
                  :message="errors.get('description')")
            quill-editor(v-model="form.description"
                         ref="quill"
                         data-behavior="product-description"
                         :options="editorOptions")

        //- price info
        section.section.price-info-wrapper
          .columns
            .column
              b-field(:label="attributeLocaleText('product', 'original_price')"
                      :type="errors.errorClassAt('price')")
                b-input(type="number"
                        placeholder="e.g. 80000"
                        v-model="form.price.original"
                        data-behavior="product-original-price"
                        @input="errors.clear('price')")
            .column
              b-field(:label="attributeLocaleText('product', 'sell_price')"
                      :type="errors.errorClassAt('price')")
                b-input(type="number"
                        placeholder="e.g. 100000"
                        v-model="form.price.sell"
                        data-behavior="product-sell-price"
                        @input="errors.clear('price')")
            .column
              b-field(:label="attributeLocaleText('product', 'discounted_price')"
                      :type="errors.errorClassAt('price')")
                b-input(type="number"
                        placeholder="e.g. 98000"
                        v-model="form.price.discounted"
                        data-behavior="product-discounted-price"
                        @input="errors.clear('price')")
          p.has-text-danger.help(v-if="errors.has('price')") {{errors.get('price')}}

        //- options
        section.section.product-options-wrapper
          b-field(:label="attributeLocaleText('product', 'is_preorder')"
                  :type="errors.errorClassAt('is_preorder')"
                  :message="errors.get('is_preorder')")
            b-switch(v-model="form.is_preorder"
                      type="is-success"
                      data-behavior="product-is-oreorder"
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
                            data-behavior="product-property-name"
                            @input="errors.clear('properties')")
                .column.is-6
                  b-field(:label="attributeLocaleText('product', 'property_value')"
                          :type="errors.errorClassAt('properties')"
                          :message="errors.get('properties')")
                    b-input(type="text"
                            placeholder="e.g. 12"
                            v-model="property.value"
                            data-behavior="product-property-value"
                            @input="errors.clear('properties')")
                .column
                  b-field(:label="attributeLocaleText('product', 'property_unit')"
                          :type="errors.errorClassAt('properties')"
                          :message="errors.get('properties')")
                    b-input(type="text"
                            placeholder="e.g. kg"
                            v-model="property.unit"
                            data-behavior="product-property-unit"
                            @input="errors.clear('properties')")

          .add-property-button.button.is-default.is-block(@click="addProperty"
                                                          data-behavior="product-add-property-button")
            .icon
              i.fa.fa-plus
            span {{actionLocaleText('admin', 'add_product_property')}}

        br

        .is-pulled-right
        .button.is-primary(@click="submitForm"
                           data-behavior="submit-button") {{actionLocaleText('admin', 'submit')}}
      //- previews
      .column
        //- TODO: create a component for roughly preview input content
        //- product-previewer(:product="this.form")
</template>

<script>
import { quillEditor, Quill } from 'vue-quill-editor'
import ImageHandler from '../../../../shared/plugins/quill_image_handler_module/image_handler'
import imageButtonHandler from '../../../../shared/plugins/quill_image_handler_module/image_button_handler'
// import ImageResize from 'quill-image-resize-module'
import Product from '../../../../shared/resource_models/product'
import Form from 'odd-form_object'

const toolbarOptions = [
  [{ size: [false, 'small', 'large', 'huge'] }], // custom dropdown
  [{ header: [false, 1, 2, 3] }],
  ['bold', 'italic', 'underline', 'strike'], // toggled buttons
  [{ align: [] }],
  ['blockquote', 'code-block'],
  [{ list: 'ordered' }, { list: 'bullet' }],
  [{ indent: '-1' }, { indent: '+1' }], // outdent/indent
  [{ color: [] }, { background: [] }], // dropdown with defaults from theme
  ['image', 'video', 'clean']
]

const imagesAttrName = 'product[images][]'
const action = 'products/uploadImages'
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
// Quill.register('modules/ImageResize', ImageResize)

export default {
  components: {
    quillEditor
  },

  // mixins: [],

  props: {
    product: {
      type: Object,
      required: false,
      default: () => {
        return new Product({
          is_preorder: false
        })
      }
    }
  },

  data() {
    return {
      form: new Form(this.product),
      editorOptions: {
        placeholder: 'e.g. A powerfull tool for your professional works.',
        modules: {
          ImageHandler: {
            dispatcher: this.$store.dispatch,
            action: action,
            imagesAttrName: imagesAttrName,
            additionalFormData: additionalFormData,
            imageUploadedCallback: this.imageUploadedCallback
          },
          // ImageResize: {},
          toolbar: {
            container: toolbarOptions,
            handlers: {
              image: () => {
                imageButtonHandler({
                  imagesAttrName,
                  additionalFormData,
                  imageUploadedCallback: this.imageUploadedCallback,
                  dispatcher: this.$store.dispatch,
                  action: action,
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
      return this.form.model.errors
    },

    isLoading() {
      return this.$store.getters['products/isLoading']
    },

    isCategoriesLoading() {
      return this.$store.getters['productCategories/isLoading']
    },

    categories() {
      return this.$store.getters['productCategories/all']
    },

    topLevelCategories() {
      return this.categories.filter(category => category.parent_id === null)
    },

    returnUrlParams() {
      if (this.product.isNewRecord()) {
        return 'product_added=1'
      } else {
        return 'product_updated=1'
      }
    }
  },

  created() {
    this.$store.dispatch('productCategories/all')
    if (this.product.isNewRecord()) {
      this.form.uploaded_image_ids = []
      this.form.properties = [propertyTemplate()]
      this.form.price = {
        original: 0,
        sell: 0,
        discounted: 0
      }
    } else {
      this.form.uploaded_image_ids = []
      this.form.price = {
        original: this.product.original_price / 100,
        sell: this.product.sell_price / 100,
        discounted: this.product.discounted_price / 100
      }
    }
  },

  // mounted() {},

  methods: {
    findCategoryBy(id) {
      return this.categories.find(category => category.id === id)
    },

    addProperty() {
      this.form.properties.push(propertyTemplate())
    },

    deleteProperty(index) {
      this.form.properties.splice(index, 1)
    },

    /*
    * Quill 的 module ImageHandler 和 imageButtonHandler 在上傳照片之後，可接受一個 Callback
    * 這邊把上傳後的圖片 ID 記錄下來，一併在儲存 product 時送給後端做後續處理。
    */
    imageUploadedCallback(image) {
      this.form.uploaded_image_ids.push(parseInt(image.id))
    },

    submitForm() {
      this.$store.dispatch('products/save', this.form.sync()).then(() => {
        Turbolinks.visit(`/admin/products?${this.returnUrlParams}`)
      })
    }
  }
}
</script>
