class Api::V1::Web::SiteConfigController < Api::V1::Web::BaseController
  before_action :for_admin_only!

  def show
    render json: global_site_configs
  end
end
