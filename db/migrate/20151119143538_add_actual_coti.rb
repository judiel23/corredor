class AddActualCoti < ActiveRecord::Migration
  def change
  	add_column :reports, :actualCoti, :string
  end
end
