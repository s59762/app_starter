class EditorAttachmentForm < ApplicationForm
  model EditorAttachment

  property :files, virtual: true

  validate :valid_files_content?

  # 將資料寫入 Product::Image
  #
  # @return [Bollean] 回傳是否成功寫入 DB
  def save
    ::ActiveRecord::Base.transaction do
      files.each do |file|
        new_attachment = EditorAttachment.create file: file
        created_attachment_ids << new_attachment.id
      end
    end
  end

  def created_attachment_ids
    @created_attachment_ids ||= []
  end

  def valid_files_content?
    errors.add(:files, :blank) if files.blank?
  end
end
