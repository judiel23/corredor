class AddPlacaColumnToCorredors < ActiveRecord::Migration
  def change
    add_column :corredors, :placa, :string
  end
end
