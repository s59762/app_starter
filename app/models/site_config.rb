# == Schema Information
#
# Table name: settings
#
#  id         :bigint(8)        not null, primary key
#  var        :string           not null
#  value      :text
#  thing_id   :integer
#  thing_type :string(30)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

# RailsSettings Model
class SiteConfig < RailsSettings::Base
  source Rails.root.join('config/site_config.yml')
  namespace Rails.env
end
