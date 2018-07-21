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

class Banner < ApplicationRecord
  allow_filters :homepage,
                :products,
                :brands,
                :sign_up
  allow_sort_fields :'banners.position'

  acts_as_list scope: [:use_type]

  enum use_type: %i(homepage products brands sign_up)

  mount_uploader :image, BannerUploader
end
