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
