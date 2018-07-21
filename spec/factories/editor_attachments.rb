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

FactoryBot.define do
  factory :editor_attachment do
    file "MyString"
    original_filename "MyString"
    association :attachable, factory: :product
  end
end
