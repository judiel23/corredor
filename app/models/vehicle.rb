class Vehicle < ActiveRecord::Base
  
  #belongs_to :make, foreign_key: "code"
  
	def self.import(file)
		Vehicle.delete_all
		CSV.foreach(file.path, :headers =>true, :encoding => 'ISO-8859-1') do |row|
			Vehicle.create!(row.to_hash)
		end
	end
end