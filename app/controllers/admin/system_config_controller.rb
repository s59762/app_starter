require_dependency 'admin/application_controller'

class Admin::SystemConfigController < Admin::ApplicationController
  def show
    @meta_tags_config = SiteConfig.meta_tags
  end
end
