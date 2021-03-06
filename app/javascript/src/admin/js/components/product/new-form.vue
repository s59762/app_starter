<template lang="pug">

.vc-product-new-form.box.content-box.is-primary
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
                  :message="errors.get('name') || messageLocaleText('product_management.help_message.name')"
                  class="required")
            b-input(type="text"
                    placeholder="e.g. iMac Pro 3.8GHz"
                    v-model="form.name"
                    data-behavior="product-name"
                    @input="errors.clear('name')")

          b-field(:label="attributeLocaleText('product', 'sku')"
                  :type="errors.errorClassAt('sku')"
                  :message="errors.get('sku') || messageLocaleText('product_management.help_message.sku')"
                  class="required")
            b-input(type="text"
                    placeholder="e.g. A001398"
                    v-model="form.sku"
                    @input="errors.clear('sku')")

          category-selector(:errors="errors"
                            :form.sync="form")

          //- 品牌
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

        //- price info
        section.section
          price-info-columns(:errors="errors"
                            :price.sync="form.price")

        //- option types
        section.section
          option-types-columns(v-if="product.isNewRecord()"
                              :errors="errors"
                              :option-types.sync="form.option_types")

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

        section.section
          properties-columns(:errors="errors"
                             :form.sync="form")

        br

        .submit-button
          .button.is-primary(@click="submitForm"
                                          data-behavior="submit-button")
            span {{ actionLocaleText('admin', 'save_and_go_to_next_step') }}
            .icon
              i.fa.fa-arrow-circle-o-right

      //- previews
      .column.preview-container
        label.label Preview
        result-preview(:form="form"
                       :product="product")

</template>

<script>
import Product from '../../../../shared/resource_models/product'
import Form from 'odd-form_object'
import queryString from 'query-string'
import CategorySelector from './category-selector.vue'
import PriceInfoColumns from './price-info-columns.vue'
import OptionTypesColumns from './option-types-columns.vue'
import PropertiesColumns from './properties-columns.vue'
import DescriptionColumn from './description-column.vue'
import ResultPreview from './result-preview.vue'

export default {
  components: {
    CategorySelector,
    PriceInfoColumns,
    OptionTypesColumns,
    PropertiesColumns,
    DescriptionColumn,
    ResultPreview
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
      form: new Form(this.product)
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
      this.form.uploaded_attachment_ids = []
      this.form.properties = []
      this.form.option_types = []
      this.form.price = {
        original: 0,
        sell: 0,
        discounted: 0
      }
    } else {
      this.form.uploaded_attachment_ids = []
      this.form.price = {
        original: this.product.original_price / 100,
        sell: this.product.sell_price / 100,
        discounted: this.product.discounted_price / 100
      }
    }

    this.assignAttributesFromQueryString()
  },

  // mounted() {},

  methods: {
    submitForm() {
      // TODO: 建立 0 元商品前先請使用者確認。
      this.$store.dispatch('products/save', this.form.sync()).then(response => {
        Turbolinks.visit(`/admin/products/${response.data.data.id}/edit?product_added=1`)
      })
    },

    assignAttributesFromQueryString() {
      const options = queryString.parse(window.location.search)

      if (options.brandId) this.form.brand_id = options.brandId
      if (options.product_category_id) this.form.top_level_category_id = options.product_category_id
      if (options.sub_category_id) this.form.sub_category_id = options.sub_category_id
    }
  }
}
</script>
