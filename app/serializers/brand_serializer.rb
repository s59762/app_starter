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

class BrandSerializer < ApplicationSerializer
  attributes :id,
             :name,
             :introduce,
             :description,
             :logo,
             :products_count,
             :created_at,
             :updated_at

  has_many :products, if: -> { instance_options[:show_products] }

  to_unix_time :created_at, :updated_at

  def logo
    object.logo.serializable_hash
  end
end
