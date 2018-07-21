# == Schema Information
#
# Table name: editor_attachments
#
#  id                :bigint(8)        not null, primary key
#  file              :string
#  original_filename :string
#  attachable_type   :string
#  attachable_id     :bigint(8)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class EditorAttachmentSerializer < ApplicationSerializer
  attributes :id,
             :file,
             :original_filename

  def file
    object.file.serializable_hash
  end
end
