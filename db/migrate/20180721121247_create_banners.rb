class CreateBanners < ActiveRecord::Migration[5.2]
  def change
    create_table :banners do |t|
      t.string :image
      t.string :alt_text
      t.integer :use_type, default: 0
      t.integer :position

      t.timestamps
    end
  end
end
