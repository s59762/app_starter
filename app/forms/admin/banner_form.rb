class Admin::BannerForm < ApplicationForm
  model Banner

  # image must at bottom, or in carrierwave module can not get attributes below `image`
  properties :alt_text,
             :use_type,
             :image

  validates :alt_text,
            :use_type,
            :image, presence: true

  def save
    ::ActiveRecord::Base.transaction do
      clear_image unless model.new_record?
      super
    end
  end

  private

  # this is a walkaround for carrierwave issue.
  # the use_types has different image size defines, if changed will have chance that carrierwave will only remove image.
  def clear_image
    return if model.use_type == use_type

    model.update image: nil
  end
end
