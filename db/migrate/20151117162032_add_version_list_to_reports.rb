class AddVersionListToReports < ActiveRecord::Migration
  def change
  	add_column :reports, :versionList, :string
  end
end
