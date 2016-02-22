require "active_support/all"
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

class IberoSegurosSuma
  
  include HTTParty
  
  URL_BASE  = 'http://190.202.23.12/wsAsegurameIbero/SumAsegAUTO'
  HEADER    = {"Content-Type" => "application/json" , "Accept" => "application/json"}
  AUTH      = { llave: "cm6oqnv9Sw" }
  
  def initialize
    
  end
  
  class << self
    
    def send_get_request(params, header)
      HTTParty.get("#{URL_BASE}", :query => params).body
    end
    
    def sumaAsegurada_automovil(params)
      puts "hola "
      puts params.to_s
      send_get_request( AUTH.merge!(params), HEADER)
    end
  end
  
  

  
  
end