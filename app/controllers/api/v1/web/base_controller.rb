class Api::V1::Web::BaseController < Api::ApiController
  include Api::JwtAuthenticatable

  private

  def global_site_configs
    {
      meta_tags: {
        site_name: ::SiteConfig['meta_tags.site_name'],
        reverse: ::SiteConfig['meta_tags.reverse'],
        separator: ::SiteConfig['meta_tags.separator'],
        description: ::SiteConfig['meta_tags.description'],
        keywords: ::SiteConfig['meta_tags.keywords']
      }
    }
  end
end
