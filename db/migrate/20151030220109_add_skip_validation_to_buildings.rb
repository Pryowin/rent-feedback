class AddSkipValidationToBuildings < ActiveRecord::Migration
  def change
    add_column :buildings, :skip_validation, :boolean, default: false
  end
end
