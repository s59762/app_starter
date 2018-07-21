class CreateEditorAttachments < ActiveRecord::Migration[5.2]
  def change
    create_table :editor_attachments do |t|
      t.string :file
      t.string :original_filename
      t.references :attachable, polymorphic: true

      t.timestamps
    end
  end
end
