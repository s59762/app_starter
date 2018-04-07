# == Schema Information
#
# Table name: product_images
#
#  id         :integer          not null, primary key
#  image      :string
#  use_case   :integer          default(0)
#  product_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryBot.define do
  factory :product_image, class: 'Product::Image' do
    image "MyString"
    use_case 0
    product nil
  end
end
