# == Schema Information
#
# Table name: banners
#
#  id         :bigint(8)        not null, primary key
#  image      :string
#  alt_text   :string
#  use_type   :integer          default("homepage")
#  position   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class BannerSerializer < ApplicationSerializer
  attributes :id,
             :image,
             :alt_text,
             :use_type,
             :position

  def image
    object.image.serializable_hash
  end
end
