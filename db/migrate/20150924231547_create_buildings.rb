class CreateBuildings < ActiveRecord::Migration
  def change
    create_table :buildings do |t|
      t.integer :building_number
      t.string :street_name, null: false
      t.string :street_address_2
      t.string :street_address_3
      t.string :city, null: false
      t.string :state
      t.string :postal_code
      t.string :country, null: false

      t.timestamps null: false
    end

    add_index :buildings, :country
    add_index :buildings, :state
    add_index :buildings, :city
    add_index :buildings, [:country, :state, :city]
    add_index :buildings, :street_name
  end
end
