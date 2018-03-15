module MetaTagsManageable
  extend ActiveSupport::Concern

  included do
    before_action :set_basic_meta_tags
  end

  private

  def set_basic_meta_tags
    set_meta_tags site: 'AppStarter',
                  reverse: true,
                  separator: ' | ',
                  description: 'odd Digital Design Studio application template.',
                  keywords: 'web-design, web-develop',
                  icon: [
                    {
                      href: '/favicon.png',
                      type: 'image/png'
                    },
                    {
                      href: '/apple-touch-icon-76x76-precomposed.png',
                      rel: 'apple-touch-icon-precomposed',
                      sizes: '76x76',
                      type: 'image/png'
                    },
                    {
                      href: '/apple-touch-icon-72x72-precomposed.png',
                      rel: 'apple-touch-icon-precomposed',
                      sizes: '72x72',
                      type: 'image/png'
                    },
                    {
                      href: '/apple-touch-icon-60x60-precomposed.png',
                      rel: 'apple-touch-icon-precomposed',
                      sizes: '60x60',
                      type: 'image/png'
                    },
                    {
                      href: '/apple-touch-icon-57x57-precomposed.png',
                      rel: 'apple-touch-icon-precomposed',
                      sizes: '57x57',
                      type: 'image/png'
                    },
                    {
                      href: '/apple-touch-icon-152x152-precomposed.png',
                      rel: 'apple-touch-icon-precomposed',
                      sizes: '152x152',
                      type: 'image/png'
                    },
                    {
                      href: '/apple-touch-icon-144x144-precomposed.png',
                      rel: 'apple-touch-icon-precomposed',
                      sizes: '144x144',
                      type: 'image/png'
                    },
                    {
                      href: '/apple-touch-icon-120x120-precomposed.png',
                      rel: 'apple-touch-icon-precomposed',
                      sizes: '120x120',
                      type: 'image/png'
                    },
                    {
                      href: '/apple-touch-icon-114x114-precomposed.png',
                      rel: 'apple-touch-icon-precomposed',
                      sizes: '114x114',
                      type: 'image/png'
                    }
                  ],
                  og: {
                    site_name: 'AppStarter',
                    type: 'website',
                    locale: 'zh_TW'
                  }
  end
end
