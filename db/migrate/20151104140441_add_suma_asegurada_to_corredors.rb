class AddSumaAseguradaToCorredors < ActiveRecord::Migration
  def change
  	add_column :corredors, :sumaAsegurada, :string
  end
end
