class AddUsosToCorredor < ActiveRecord::Migration
  def change
  	add_column :corredors, :vehicle_use, :string
  	add_column :corredors, :vehicle_type, :string
  end
end
