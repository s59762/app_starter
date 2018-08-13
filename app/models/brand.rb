# == Schema Information
#
# Table name: brands
#
#  id             :bigint(8)        not null, primary key
#  name           :string
#  introduce      :string
#  description    :text
#  logo           :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  products_count :integer          default(0)
#

class Brand < ApplicationRecord
  include EditorAttachable

  allow_sort_fields :id,
                    :name,
                    :products_count,
                    :created_at,
                    :updated_at

  has_many :products, dependent: :nullify
  has_many :banners, dependent: :destroy

  mount_uploader :logo, BrandLogoUploader
end
