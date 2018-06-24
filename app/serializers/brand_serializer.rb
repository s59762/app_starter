class BrandSerializer < ApplicationSerializer
  attributes :id,
             :name,
             :introduce,
             :description,
             :logo,
             :created_at,
             :updated_at

  has_many :products, if: -> { instance_options[:show_products] }

  to_unix_time :created_at, :updated_at
end
