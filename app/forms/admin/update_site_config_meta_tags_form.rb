class Admin::UpdateSiteConfigMetaTagsForm < ApplicationForm
  model SiteConfig

  PROPERTIES = %i[
    site_name
    reverse
    separator
    description
    keywords
  ].freeze

  properties :site_name,
             :reverse,
             :separator,
             :description,
             :keywords, virtual: true

  validates :site_name,
            :separator,
            :description,
            :keywords, presence: true

  # 將資料寫入 SiteConfig
  #
  # @return [Bollean] 回傳是否成功寫入 DB
  def save
    ::ActiveRecord::Base.transaction do
      PROPERTIES.each do |property|
        check_and_update(property)
      end
    end
  end

  private

  def check_and_update(config_name)
    original_value = SiteConfig["meta_tags.#{config_name}"]
    new_value      = send(config_name)

    SiteConfig["meta_tags.#{config_name}"] = new_value if original_value != new_value
  end
end
