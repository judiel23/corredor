class AddSumaToCotizapp < ActiveRecord::Migration
  def change
  	add_column :cotiz_apps, :sumaAsegurada, :string
  end
end
