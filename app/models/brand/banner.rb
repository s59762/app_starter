# == Schema Information
#
# Table name: brand_banners
#
#  id         :bigint(8)        not null, primary key
#  image      :string
#  alt_text   :string
#  brand_id   :bigint(8)
#  position   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Brand::Banner < ApplicationRecord
  allow_sort_fields :'brand_banners.position'

  belongs_to :brand, touch: true

  acts_as_list scope: [:brand_id]

  mount_uploader :image, BannerUploader
end
