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

class Product::Image < ApplicationRecord
  belongs_to :product, optional: true, touch: true

  enum use_case: %i(normal description)

  mount_uploader :image, ProductImageUploader
end
