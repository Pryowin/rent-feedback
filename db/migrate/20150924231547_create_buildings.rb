class CreateBuildings < ActiveRecord::Migration
  def change
    create_table :buildings do |t|
      t.string :street_address,     null:false
      t.string :street_address_2
      t.string :street_address_3
      t.string :city,               null:false
      t.string :state
      t.string :postal_code
      t.string :country,            null: false

      t.timestamps null: false
    end
  end
end
