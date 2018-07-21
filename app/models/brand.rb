# == Schema Information
#
# Table name: brands
#
#  id             :bigint(8)        not null, primary key
#  name           :string
#  introduce      :string
#  description    :string
#  logo           :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  products_count :integer          default(0)
#

class Brand < ApplicationRecord
  allow_sort_fields :'brands.id',
                    :'brands.name',
                    :'brands.created_at',
                    :'brands.updated_at'

  has_many :products, dependent: :nullify
  has_many :banners, -> { order(position: :asc) }, dependent: :destroy

  mount_uploader :logo, BrandLogoUploader
end
