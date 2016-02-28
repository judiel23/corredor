class Make < ActiveRecord::Base
  
  #has_many :vehicles, foreign_key: "make", dependent: :destroy
  
	def self.import(file)
		Make.delete_all
		CSV.foreach(file.path, :headers =>true, :encoding => 'ISO-8859-1') do |row|
			Make.create!(row.to_hash)
		end
	end
end
