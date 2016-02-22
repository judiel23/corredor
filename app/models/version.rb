class Version < ActiveRecord::Base
  def self.import(file)
		Version.delete_all
		CSV.foreach(file.path, :headers =>true, :encoding => 'ISO-8859-1', :col_sep => ";") do |row|
			Version.create!(row.to_hash)
		end
	end
end
