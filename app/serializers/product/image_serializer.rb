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
#  is_cover          :boolean          default(FALSE)
#  variant_id        :bigint(8)
#

class Product::ImageSerializer < ApplicationSerializer
  type 'product_images'

  attributes :id,
             :use_case,
             :url,
             :squal_image,
             :thumb_url,
             :original_filename,
             :is_cover,
             :variant_id,
             :product_id

  belongs_to :product, optional: true, if: -> { instance_options[:show_product] }
  belongs_to :variant, optional: true, if: -> { instance_options[:show_variant] }

  def url
    object.image.url
  end

  def squal_image
    return nil if object.description?

    object.image.squal.url
  end

  def thumb_url
    object.image.thumb.url
  end
end
