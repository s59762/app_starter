class Api::V1::Web::SiteConfigController < Api::V1::Web::BaseController
  before_action :for_admin_only!

  def show
    configs = {
      meta_tags: SiteConfig.meta_tags
    }

    render json: configs
  end
end
