class CreateVehicles < ActiveRecord::Migration
  def change
    create_table :vehicles do |t|
      t.string :make
      t.string :code
      t.string :model
      t.string :clasiveh
      t.string :vehicle_size

      t.timestamps null: false
    end
  end
end
