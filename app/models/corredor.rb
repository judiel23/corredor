class Corredor < ActiveRecord::Base

	before_save do
		self.ced = "#{nacion}#{cedula}"
		self.fnacimiento = "#{dia}/#{mes}/#{anio}"
		self.telefono = "#{cod1}-#{tfijo}"
		self.celular = "#{cod2}-#{tcelular}"
	end

	has_many :insurance_responses
end