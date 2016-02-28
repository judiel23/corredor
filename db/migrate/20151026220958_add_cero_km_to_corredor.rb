class AddCeroKmToCorredor < ActiveRecord::Migration
  def change
  	add_column :corredors, :cerokm, :string
  end
end
