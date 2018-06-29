<template lang="pug">

.vc-product-form.box.content-box.is-primary
  .box-header.with-border
    h3.subtitle {{ pageTitleLocaleText('admin', 'products', 'form') }}
    b-message(type="is-info") {{ messageLocaleText('product_management.please_provide_basic_info_for_new_product_and_make_advence_config_in_next_step') }}
  .box-body
    .columns
      //- input fields
      .column.is-7
        b-loading(:active.sync="isLoading"
                  :is-full-page="false")

        //- basic info
        section.section.basic-info-wrapper
          //- 商品名稱
          b-field(:label="attributeLocaleText('product', 'name')"
                  :type="errors.errorClassAt('name')"
                  :message="errors.get('name')"
                  class="required")
            b-input(type="text"
                    placeholder="e.g. iMac Pro 3.8GHz"
                    v-model="form.name"
                    data-behavior="product-name"
                    @input="errors.clear('name')")

          .columns
            .column
              //- 主分類
              b-field(:label="attributeLocaleText('product', 'category_id')"
                      :type="errors.errorClassAt('top_level_category_id')"
                      :message="errors.get('top_level_category_id')"
                      class="required")
                b-select(v-model="form.top_level_category_id"
                        :loading="isCategoriesLoading"
                        :placeholder="messageLocaleText('help.please_select_a_category')"
                        @input="errors.clear('top_level_category_id')"
                        expanded)
                  option(v-for="topLevelCategory in topLevelCategories"
                        :label="topLevelCategory.name"
                        :value="topLevelCategory.id"
                        :key="topLevelCategory.id")
                    | {{ topLevelCategory.name }}
            .column(v-if="findCategoryBy(form.top_level_category_id)")
              //- 子分類
              b-field(:label="attributeLocaleText('product', 'sub_category')"
                      :type="errors.errorClassAt('sub_category_id')"
                      :message="errors.get('sub_category_id')")
                b-select(v-model="form.sub_category_id"
                        :loading="isCategoriesLoading"
                        :placeholder="messageLocaleText('help.no_sub_category')"
                        @input="errors.clear('sub_category_id')"
                        expanded)
                  option(:label="messageLocaleText('help.no_sub_category')"
                        :value="undefined")
                  option(v-for="subCategory in findCategoryBy(form.top_level_category_id).sub_categories"
                        :label="findCategoryBy(subCategory.id).name"
                        :value="subCategory.id"
                        :key="subCategory.id")
                    | {{ findCategoryBy(subCategory.id).name }}

          //- 品牌
          b-field(:label="attributeLocaleText('product', 'brand_id')"
                  :type="errors.errorClassAt('brand_id')"
                  :message="errors.get('brand_id')")
            b-select(v-model="form.brand_id"
                     :loading="isCategoriesLoading"
                     :placeholder="messageLocaleText('help.please_select_a_brand')"
                     @input="errors.clear('brand_id')"
                     expanded)
              option(v-for="brand in brands"
                    :value="brand.id"
                    :key="brand.id")
                | {{ brand.name }}

          //- 商品描述
          //- b-field(:label="attributeLocaleText('product', 'description')"
          //-         :type="errors.errorClassAt('description')"
          //-         :message="errors.get('description')"
          //-         class="required")
          //-   quill-editor(v-model="form.description"
          //-                ref="quill"
          //-                data-behavior="product-description"
          //-                :options="editorOptions")

        //- price info
        price-info-columns(:errors="errors"
                           :price.sync="form.price")

        //- option types
        option-types-columns(v-if="product.isNewRecord()"
                             :errors="errors"
                             :option-types="form.option_types")

        //- options
        //- section.section.product-options-wrapper
        //-   //- 預購？
        //-   b-field(:label="attributeLocaleText('product', 'is_preorder')"
        //-           :type="errors.errorClassAt('is_preorder')"
        //-           :message="errors.get('is_preorder')")
        //-     b-switch(v-model="form.is_preorder"
        //-               type="is-success"
        //-               data-behavior="product-is-oreorder"
        //-               @input="errors.clear('is_preorder')")
        //-       | {{enumLocaleText('product', 'is_preorder', form.is_preorder)}}

        properties
        section.section
          h4.section-title {{pageTitleLocaleText('admin', 'products', 'property_fields')}}

          .properties-wrapper
            //- 基本商品屬性（體積、重量）
            h5.sub-title {{pageTitleLocaleText('admin', 'products', 'basic_properties')}}
            .property-fields(v-for="basicProperty in basicProperties")
              .columns
                .column
                  b-field(:label="attributeLocaleText('product', 'property_name')"
                          :type="errors.errorClassAt('properties')")
                    b-input(type="text"
                            :value="attributeLocaleText('product', basicProperty.name)"
                            disabled)
                .column.is-6
                  b-field(:label="attributeLocaleText('product', 'property_value')"
                          :type="errors.errorClassAt('properties')"
                          :message="errors.get(basicProperty.name)")
                    b-input(type="number"
                            placeholder="e.g. 80"
                            v-model="form[basicProperty.name]"
                            data-behavior="product-width-value"
                            @input="errors.clear(basicProperty.name)")
                .column
                  b-field(:label="attributeLocaleText('product', 'property_unit')"
                          :type="errors.errorClassAt('properties')")
                    b-input(type="text"
                            :value="basicProperty.unit"
                            disabled)
            //- 自訂商品屬性
            h5.sub-title(v-if="form.properties.length > 0") {{pageTitleLocaleText('admin', 'products', 'extra_properties')}}
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
                            placeholder="e.g. Battery"
                            v-model="property.name"
                            data-behavior="product-property-name"
                            @input="errors.clear('properties')")
                .column.is-6
                  b-field(:label="attributeLocaleText('product', 'property_value')"
                          :type="errors.errorClassAt('properties')"
                          :message="errors.get('properties')")
                    b-input(type="text"
                            placeholder="e.g. 12000"
                            v-model="property.value"
                            data-behavior="product-property-value"
                            @input="errors.clear('properties')")
                .column
                  b-field(:label="attributeLocaleText('product', 'property_unit')"
                          :type="errors.errorClassAt('properties')"
                          :message="errors.get('properties')")
                    b-input(type="text"
                            placeholder="e.g. mAh"
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
import PriceInfoColumns from './price-info-columns.vue'
import OptionTypesColumns from './option-types-columns.vue'

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
const propertyTemplate = () => {
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
    quillEditor,
    PriceInfoColumns,
    OptionTypesColumns
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

    isBrandsLoading() {
      return this.$store.getters['brands/isLoading']
    },

    categories() {
      return this.$store.getters['productCategories/all']
    },

    brands() {
      return this.$store.getters['brands/all']
    },

    basicProperties() {
      return [
        {
          name: 'width',
          unit: 'CM'
        },
        {
          name: 'depth',
          unit: 'CM'
        },
        {
          name: 'height',
          unit: 'CM'
        },
        {
          name: 'weight',
          unit: 'KG'
        }
      ]
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
    this.$store.dispatch('brands/all')
    if (this.product.isNewRecord()) {
      this.form.uploaded_image_ids = []
      this.form.properties = []
      this.form.option_types = []
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
      return this.categories.find(category => category.id == id)
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
      // TODO: 建立 0 元商品前先請使用者確認。
      this.$store.dispatch('products/save', this.form.sync()).then(() => {
        Turbolinks.visit(`/admin/products?${this.returnUrlParams}`)
      })
    }
  }
}
</script>
