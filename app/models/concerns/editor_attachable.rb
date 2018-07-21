# 提供 Editor 附件上傳的功能，包含 editor_attachments 關聯以及附件後續處理的方法
module EditorAttachable
  extend ActiveSupport::Concern

  included do
    has_many :editor_attachments, as: :attachable, dependent: :destroy
  end

  # 處理 Editor 上傳的附件。
  # 把確定使用中的 attachments 與 modle 本身建立關聯，並找出不再使用的 attachment 進行刪除。
  #
  # @param [Array] attachment_ids 儲存 editor 內容的欄位中，確認為使用中的 attachment ids
  # @param [Class] attachment_model attachment 的 modle Class，預設為 `EditorAttachment`
  # @param [Class] association_name 關聯名稱，預設為 `:editor_attachments`
  # @param [Array] uploaded_attachment_ids model 儲存前所有上傳過的附件 ids
  def process_uploaded_attachments(attachment_ids,
                                   attachment_model: EditorAttachment,
                                   association_name: :editor_attachments,
                                   uploaded_attachment_ids: [])
    current_attachment_ids = send(association_name).select(:id).map(&:id)
    unused_image_ids = uploaded_attachment_ids + current_attachment_ids - attachment_ids

    attachment_model.where(id: attachment_ids).each do |attachment|
      attachment.update attachable: self
    end

    attachment_model.where(id: unused_image_ids).destroy_all
  end
end
