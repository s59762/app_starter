class CreateUserShippingInfos < ActiveRecord::Migration[5.2]
  def change
    create_table :user_shipping_infos do |t|
      t.string :recipient
      t.string :phone
      t.jsonb :address
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
