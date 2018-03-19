class Api::V1::Web::SiteConfig::MetaTagsController < Api::V1::Web::BaseController
  before_action :for_admin_only!

  def update
    form = Admin::UpdateSiteConfigMetaTagsForm.new(SiteConfig.meta_tags)

    return raise ValidationFailureException, form unless form.validate(meta_tag_params)

    form.save

    render json: global_site_configs
  end

  private

  def meta_tag_params
    ActiveModelSerializers::Deserialization.jsonapi_parse(params)
  end
end
