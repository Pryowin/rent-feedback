class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.integer :user_id, null: false
      t.integer :building_id
      t.string :postal_code
      t.string :city
      t.boolean :active, null: false, default: true

      t.timestamps null: false
    end
    add_index :subscriptions, :user_id
  end
end
