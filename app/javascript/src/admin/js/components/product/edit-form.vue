<template lang="pug">

.vc-product-edit-form.box.content-box(:class="dirtyCheckClass")
  .box-body
    .columns
      //- input fields
      .column.is-7
        b-loading(:active.sync="isLoading"
                  :is-full-page="false")

        b-tabs(v-model="activeTab"
               type="is-boxed"
               size="is-small")
          //- 基本資料
          b-tab-item(:label="pageTitleLocaleText('admin', 'products', 'basic_product_info')"
                     icon="file-text-o")
            //- TODO: Dev only
            section.section
              .image-list
                image-editable-unit(v-for="image in images"
                                    :image="image"
                                    :key="image.id")

            section.section
              b-field(:label="attributeLocaleText('product', 'name')"
                      :type="errors.errorClassAt('name')"
                      :message="errors.get('name')"
                      class="required")
                b-input(type="text"
                        placeholder="e.g. iMac Pro 3.8GHz"
                        v-model="form.name"
                        data-behavior="product-name"
                        @input="errors.clear('name')")

              category-selector(:errors="errors"
                                :form.sync="form")

              b-field(:label="attributeLocaleText('product', 'brand_id')"
                      :type="errors.errorClassAt('brand_id')"
                      :message="errors.get('brand_id')")
                b-select(v-model="form.brand_id"
                        :loading="isBrandsLoading"
                        :placeholder="messageLocaleText('help.please_select_a_brand')"
                        @input="errors.clear('brand_id')"
                        expanded)
                  option(v-for="brand in brands"
                        :value="brand.id"
                        :key="brand.id")
                    | {{ brand.name }}

            section.section
              description-column(:errors="errors"
                                 :form.sync="form")

            .button.is-primary.is-block(@click="submitForm"
                                        :class="{'is-loading': isLoading}"
                                        data-behavior="submit-button")
              .icon
                i.fa.fa-floppy-o
              span {{ actionLocaleText('admin', 'save') }}

          //- 選項與屬性
          b-tab-item(:label="pageTitleLocaleText('admin', 'products', 'options_and_properties')"
                     icon="list-ol")
            section.section
              option-type-editor(:option-types="optionTypes")

            section.section
              properties-columns(:errors="errors"
                                 :form.sync="form")

            .button.is-primary.is-block(@click="submitForm"
                                        :class="{'is-loading': isLoading}"
                                        data-behavior="submit-button")
              .icon
                i.fa.fa-floppy-o
              span {{ actionLocaleText('admin', 'save') }}

          //- 規格設定
          b-tab-item(:label="pageTitleLocaleText('admin', 'products', 'variants_management')"
                     icon="barcode")
            variant-editable-unit(v-for="variant in variants"
                                  :variant="variant")

          //- 圖片管理
          b-tab-item(:label="pageTitleLocaleText('admin', 'products', 'images_management')"
                     icon="picture-o")

          //- 庫存管理
          b-tab-item(:label="pageTitleLocaleText('admin', 'products', 'stocks_management')"
                     icon="calculator")
            stock-management-unit(v-for="variant in variants"
                                  :variant="variant")

          //- SEO 設定
          b-tab-item(:label="pageTitleLocaleText('admin', 'products', 'seo_config')"
                     icon="wpforms")
            section.section
              b-field(:label="attributeLocaleText('product', 'meta_title')"
                      :type="errors.errorClassAt('meta_title')"
                      :message="errors.get('meta_title') || messageLocaleText('product_management.help_message.meta_title')")
                b-input(type="text"
                        v-model="form.meta_title"
                        @input="errors.clear('meta_title')")
              b-field(:label="attributeLocaleText('product', 'meta_description')"
                      :type="errors.errorClassAt('meta_description')"
                      :message="errors.get('meta_description') || messageLocaleText('product_management.help_message.meta_description')")
                b-input(type="textarea"
                        v-model="form.meta_description"
                        @input="errors.clear('meta_description')")
              b-field(:label="attributeLocaleText('product', 'meta_keywords')"
                      :type="errors.errorClassAt('meta_keywords')"
                      :message="errors.get('meta_keywords') || messageLocaleText('product_management.help_message.meta_keywords')")
                b-input(type="text"
                        v-model="form.meta_keywords"
                        @input="errors.clear('meta_keywords')")

            .button.is-primary.is-block(@click="submitForm"
                                        :class="{'is-loading': isLoading}"
                                        data-behavior="submit-button")
              .icon
                i.fa.fa-floppy-o
              span {{ actionLocaleText('admin', 'save') }}

      //- previews
      .column
        //- TODO: create a component for roughly preview input content
        //- product-previewer(:product="this.form")
</template>

<script>
import Product from '../../../../shared/resource_models/product'
import Form from 'odd-form_object'
import CategorySelector from './category-selector.vue'
import OptionTypeEditor from './option-type-editor.vue'
import PropertiesColumns from './properties-columns.vue'
import DescriptionColumn from './description-column.vue'
import VariantEditableUnit from '../product_variant/editable-unit.vue'
import StockManagementUnit from '../product_variant/stock-management-unit.vue'
import ImageEditableUnit from '../product_image/editable-unit.vue'

export default {
  components: {
    CategorySelector,
    OptionTypeEditor,
    PropertiesColumns,
    DescriptionColumn,
    VariantEditableUnit,
    StockManagementUnit,
    ImageEditableUnit
  },

  // mixins: [],

  props: {
    product: {
      type: Object,
      required: true,
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
      activeTab: 0,
      isDataSaved: true
    }
  },

  computed: {
    errors() {
      return this.form.model.errors
    },

    isLoading() {
      return this.$store.getters['products/isLoading']
    },

    isBrandsLoading() {
      return this.$store.getters['brands/isLoading']
    },

    brands() {
      return this.$store.getters['brands/all']
    },

    optionTypes() {
      return this.$store.getters['productOptionTypes/all']
    },

    variants() {
      return this.$store.getters['productVariants/all']
    },

    images() {
      return this.$store.getters['productImages/all']
    },

    dirtyCheckClass() {
      return {
        'is-primary': this.isDataSaved,
        'is-danger': !this.isDataSaved
      }
    }
  },

  created() {
    this.$store.dispatch('brands/all')
    this.form.uploaded_image_ids = []
    this.form.price = {
      original: this.product.original_price / 100,
      sell: this.product.sell_price / 100,
      discounted: this.product.discounted_price / 100
    }
  },

  // mounted() {},

  methods: {
    submitForm() {
      // TODO: 建立 0 元商品前先請使用者確認。
      this.$store.dispatch('products/save', this.form.sync()).then(() => {
        this.$store.dispatch('addFlashMessage', [
          'success',
          this.messageLocaleText('resource_updated_successfully', { resource: this.modelNameLocaleText('product') })
        ])
      })
    }
  }
}
</script>
