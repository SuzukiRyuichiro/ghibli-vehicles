class CreateVehicles < ActiveRecord::Migration[7.0]
  def change
    create_table :vehicles do |t|
      t.string :name
      t.string :description
      t.string :vehicle_class
      t.string :pilot

      t.timestamps
    end
  end
end
