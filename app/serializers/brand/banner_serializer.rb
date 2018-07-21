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

class Brand::BannerSerializer < ApplicationSerializer
  type 'brand_banners'

  attributes :id,
             :image,
             :alt_text,
             :brand_id,
             :position

  def image
    object.image.serializable_hash
  end
end
