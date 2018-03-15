# RailsSettings Model
class SiteConfig < RailsSettings::Base
  source Rails.root.join("config/site_config.yml")
  namespace Rails.env
end
