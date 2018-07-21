class Admin::BrandForm < ApplicationForm
  model Brand

  properties :name,
             :introduce,
             :description
  property :uploaded_attachment_ids, virtual: true

  validates :name, presence: true

  # 將資料寫入 ModelName
  #
  # @return [Bollean] 回傳是否成功寫入 DB
  def save
    attachment_ids = description.present? ? description.scan(/\/uploads\/editor_attachment\/file\/([0-9]+)/).flatten.map(&:to_i) : []

    sync

    ::ActiveRecord::Base.transaction do
      model.save
      model.process_uploaded_attachments(attachment_ids, uploaded_attachment_ids: uploaded_attachment_ids)
    end
  end
end
