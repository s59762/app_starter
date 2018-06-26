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

  def check_policy(is_valid, message: 'user role can not use this API')
    raise PolicyFailureException, message unless is_valid
  end

  def current_cart
    @current_cart ||= Cart.find_by(id: session[:cart_id])

    raise CartFetchFailureException, 'No cart info in session of current user. This API is for browser use only.' unless @current_cart

    @current_cart
  end
end
