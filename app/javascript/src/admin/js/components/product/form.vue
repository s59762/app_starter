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

          //- 商品描述
          description-column(:errors="errors"
                             :form.sync="form")

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
        section.section.product-options-wrapper
          //- 預購？
          b-field(:label="attributeLocaleText('product', 'is_preorder')"
                  :type="errors.errorClassAt('is_preorder')"
                  :message="errors.get('is_preorder')")
            b-switch(v-model="form.is_preorder"
                      type="is-success"
                      data-behavior="product-is-oreorder"
                      @input="errors.clear('is_preorder')")
              | {{enumLocaleText('product', 'is_preorder', form.is_preorder)}}

        section.section
          properties-columns(:errors="errors"
                             :form.sync="form")

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
        Turbolinks.visit(`/admin/products?${this.returnUrlParams}`)
      })
    }
  }
}
</script>
