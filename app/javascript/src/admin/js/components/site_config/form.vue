<template lang="pug">

.site-config-form.box.content-box.is-primary(v-if="isConfigsNotEmpty")
  .box-header.with-border
    h2.box-title {{pageTitleLocaleText('admin', 'system_config', 'meta_tags_config')}}
  .box-body
    .box.form-container-box.is-default
      section.section.meta-tags-config
        h3.section-title {{pageTitleLocaleText('admin', 'system_config', 'site_title_style')}}
        .columns
          .column.is-7
            b-field(:label="attributeLocaleText('site_config', 'site_name')"
                    :type="form.errorClassAt('site_name')"
                    :message="form.errors.get('site_name')"
                    horizontal)
              b-input(type="text"
                      placeholder="Your Site Name"
                      v-model="form.site_name"
                      @input="form.errors.clear('site_name')")

            b-field(:label="attributeLocaleText('site_config', 'separator')"
                    :type="form.errorClassAt('separator')"
                    :message="form.errors.get('separator')"
                    horizontal)
              b-input(type="text"
                      placeholder="e.g. :: or ||"
                      v-model="form.separator"
                      @input="form.errors.clear('separator')")
            b-field(:label="attributeLocaleText('site_config', 'reverse')"
                    :type="form.errorClassAt('reverse')"
                    :message="form.errors.get('reverse')"
                    horizontal)
              b-switch(v-model="form.reverse"
                       size="is-large"
                       type="is-success"
                       @input="form.errors.clear('reverse')")
          .style-preview-container.column.is-5
            h4.subtitle {{pageTitleLocaleText('admin', 'system_config', 'style_preview')}}
            .browser-mock
              span.tab {{titlePreview}}
              .url-input http://www.my-website.com

      section.section.seo-config
        h3.section-title {{pageTitleLocaleText('admin', 'system_config', 'seo_config')}}
        .columns
          .column.is-7
            b-field(:label="attributeLocaleText('site_config', 'description')"
                    :type="form.errorClassAt('description')"
                    :message="form.errors.get('description')"
                    horizontal)
              b-input(type="text"
                      placeholder="e.g. Jone Doe"
                      v-model="form.description"
                      @input="form.errors.clear('description')")
            b-field(:label="attributeLocaleText('site_config', 'keywords')"
                    :type="form.errorClassAt('keywords')"
                    :message="form.errors.get('keywords')"
                    horizontal)
              b-input(type="text"
                      placeholder="e.g. Jone Doe"
                      v-model="form.keywords"
                      @input="form.errors.clear('keywords')")

    .is-pulled-right
      .button.is-primary(@click="updateMetaTags") {{actionLocaleText('admin', 'update_config')}}

</template>

<script>
import Form from '../../../../shared/form'

export default {
  // components: {},
  // mixins: [],
  props: {
    configs: {
      type: Object,
      required: true
    }
  },

  watch: {
    configs() {
      this.form = new Form(
        {
          site_name: this.configs.meta_tags.site_name,
          reverse: this.configs.meta_tags.reverse,
          separator: this.configs.meta_tags.separator,
          description: this.configs.meta_tags.description,
          keywords: this.configs.meta_tags.keywords
        },
        this.$store.dispatch,
        this.$store.getters['siteConfigs/errors']
      )
    },

    titlePreview(value) {
      document.title = value
    }
  },

  data() {
    return {
      form: {}
    }
  },

  computed: {
    isConfigsNotEmpty() {
      return Object.keys(this.configs).length > 0
    },

    titlePreview() {
      let result = [this.form.site_name, this.form.separator, '系統設定', this.form.separator, '選項列表']

      if (this.form.reverse) {
        return result.reverse().join(' ')
      } else {
        return result.join(' ')
      }
    },

    metaTagsRequestBody() {
      return {
        data: {
          type: 'site-configs',
          attributes: this.form.data()
        }
      }
    }
  },

  // created() {},
  // mounted() {},
  methods: {
    updateMetaTags() {
      this.$store.dispatch('siteConfigs/updateMetaTags', this.metaTagsRequestBody())
    }
  }
}
</script>
