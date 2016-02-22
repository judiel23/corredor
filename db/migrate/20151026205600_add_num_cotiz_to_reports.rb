class AddNumCotizToReports < ActiveRecord::Migration
  def change
      add_column :reports, :num_cotiza, :string
  end
end
