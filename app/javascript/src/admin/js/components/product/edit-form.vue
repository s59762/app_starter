<template lang="pug">

.vc-product-edit-form.box.content-box.is-primary
  .box-body
    .columns
      //- input fields
      .column.is-7
        b-loading(:active.sync="isLoading"
                  :is-full-page="false")

        b-tabs(v-model="activeTab"
               type="is-boxed"
               size="is-small")
          b-tab-item(label="基本資料"
                     icon="file-text-o")
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
                                        data-behavior="submit-button")
              .icon
                i.fa.fa-floppy-o
              span {{ actionLocaleText('admin', 'save') }}

          b-tab-item(label="選項管理"
                     icon="list-ol")
            section.section
              properties-columns(:errors="errors"
                                 :form.sync="form")

            .button.is-primary.is-block(@click="submitForm"
                                        data-behavior="submit-button")
              .icon
                i.fa.fa-floppy-o
              span {{ actionLocaleText('admin', 'save') }}
          b-tab-item(label="規格設定"
                     icon="barcode")
          b-tab-item(label="庫存管理"
                     icon="calculator")
          b-tab-item(label="SEO 設定"
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
import PriceInfoColumns from './price-info-columns.vue'
import OptionTypesColumns from './option-types-columns.vue'
import PropertiesColumns from './propertiess-columns.vue'
import DescriptionColumn from './description-column.vue'

export default {
  components: {
    CategorySelector,
    PriceInfoColumns,
    OptionTypesColumns,
    PropertiesColumns,
    DescriptionColumn
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
      activeTab: 0
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
    }
  },

  created() {
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
