class AddCotizacionToReports < ActiveRecord::Migration
  def change
  	add_column :reports, :cotizacion, :string
  end
end
