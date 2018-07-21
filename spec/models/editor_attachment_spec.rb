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

require 'rails_helper'

RSpec.describe EditorAttachment, type: :model do
  it { should belong_to :attachable }
end
