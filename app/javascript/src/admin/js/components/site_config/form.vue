<template lang="pug">

.vc-site-config-form.box.content-box.is-primary(v-if="isConfigsNotEmpty")
  .box-header.with-border
    h2.box-title {{pageTitleLocaleText('admin', 'system_config', 'meta_tags_config')}}
  .box-body
    section.section.meta-tags-config
      h3.section-title {{pageTitleLocaleText('admin', 'system_config', 'site_title_style')}}
      .columns
        .column.is-7
          b-field(:label="attributeLocaleText('site_config', 'site_name')"
                  :type="errors.errorClassAt('site_name')"
                  :message="errors.get('site_name')")
            b-input(type="text"
                    placeholder="Your Site Name"
                    v-model="form.site_name"
                    @input="errors.clear('site_name')")

          b-field(:label="attributeLocaleText('site_config', 'separator')"
                  :type="errors.errorClassAt('separator')"
                  :message="errors.get('separator')")
            b-input(type="text"
                    placeholder="e.g. :: or ||"
                    v-model="form.separator"
                    @input="errors.clear('separator')")
          b-field(:label="attributeLocaleText('site_config', 'reverse')"
                  :type="errors.errorClassAt('reverse')"
                  :message="errors.get('reverse')")
            b-switch(v-model="form.reverse"
                      size="is-large"
                      type="is-success"
                      @input="errors.clear('reverse')")
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
                  :type="errors.errorClassAt('description')"
                  :message="errors.get('description')")
            b-input(type="textarea"
                    placeholder="e.g. Jone Doe"
                    v-model="form.description"
                    @input="errors.clear('description')")
          p.help {{messageLocaleText('help.site_config_meta_description_should_not_over_140_words')}}
          br
          b-field(:label="attributeLocaleText('site_config', 'keywords')"
                  :type="errors.errorClassAt('keywords')"
                  :message="errors.get('keywords')")
            b-input(type="text"
                    placeholder="e.g. Jone Doe"
                    v-model="form.keywords"
                    @input="errors.clear('keywords')")
          p.help {{messageLocaleText('help.site_config_meta_keywords_please_seprate_with_comma')}}

    .is-pulled-right
      .button.is-primary(@click="updateMetaTags") {{actionLocaleText('admin', 'update_config')}}

</template>

<script>
import Form from '../../../../shared/forms/admin/site_config_meta_tags_form'

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
      this.form = new Form(this.configs)
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
    errors() {
      return this.$store.getters['siteConfigs/errors']
    },

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
    }
  },

  // created() {},
  // mounted() {},
  methods: {
    updateMetaTags() {
      this.$store.dispatch('siteConfigs/updateMetaTags', this.form.sync()).then(() => {
        this.$store.dispatch('addFlashMessage', [
          'success',
          this.messageLocaleText('resource_updated_successfully', { resource: this.modelNameLocaleText('site_config') })
        ])
      })
    }
  }
}
</script>
