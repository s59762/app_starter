class MoveProductBasicPropertyToProductVariants < ActiveRecord::Migration[5.2]
  def change
    remove_column :products, :width, :decimal
    remove_column :products, :depth, :decimal
    remove_column :products, :height, :decimal
    remove_column :products, :weight, :decimal
    remove_column :products, :original_price_cents, :integer, default: 0, null: false
    remove_column :products, :original_price_currency, :string, default: 'TWD', null: false
    remove_column :products, :sell_price_cents, :integer, default: 0, null: false
    remove_column :products, :sell_price_currency, :string, default: 'TWD', null: false
    remove_column :products, :discounted_price_cents, :integer, default: 0, null: false
    remove_column :products, :discounted_price_currency, :string, default: 'TWD', null: false
  end
end
