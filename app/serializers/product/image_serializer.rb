# == Schema Information
#
# Table name: product_images
#
#  id                :bigint(8)        not null, primary key
#  image             :string
#  use_case          :integer          default("normal")
#  original_filename :string
#  product_id        :bigint(8)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Product::ImageSerializer < ApplicationSerializer
  attributes :id,
             :use_case,
             :url,
             :thumb_url,
             :original_filename

  belongs_to :product, optional: true

  def url
    object.image.url
  end

  def thumb_url
    object.image.thumb.url
  end
end
