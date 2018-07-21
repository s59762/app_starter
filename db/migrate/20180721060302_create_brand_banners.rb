class CreateBrandBanners < ActiveRecord::Migration[5.2]
  def change
    create_table :brand_banners do |t|
      t.string :image
      t.string :alt_text
      t.references :brand, foreign_key: true
      t.integer :position

      t.timestamps
    end
  end
end
