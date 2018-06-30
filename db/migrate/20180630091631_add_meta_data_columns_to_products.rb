class AddMetaDataColumnsToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :meta_title, :string
    add_column :products, :meta_description, :string
    add_column :products, :meta_keywords, :string
  end
end
