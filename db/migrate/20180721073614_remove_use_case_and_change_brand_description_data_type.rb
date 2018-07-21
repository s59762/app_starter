class RemoveUseCaseAndChangeBrandDescriptionDataType < ActiveRecord::Migration[5.2]
  def up
    change_column :brands, :description, :text
    remove_column :product_images, :use_case, :integer, default: 0
  end

  def down
    change_column :brands, :description, :string
    add_column :product_images, :use_case, :integer, default: 0
  end
end
