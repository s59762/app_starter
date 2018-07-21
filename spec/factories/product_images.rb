# == Schema Information
#
# Table name: product_images
#
#  id                :bigint(8)        not null, primary key
#  image             :string
#  original_filename :string
#  product_id        :bigint(8)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  is_cover          :boolean          default(FALSE)
#  variant_id        :bigint(8)
#

FactoryBot.define do
  factory :product_image, class: 'Product::Image' do
    image "MyString"
    product nil
  end
end
