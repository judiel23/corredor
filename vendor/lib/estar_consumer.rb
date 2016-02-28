require "active_support/all"
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.


# Informacion Importante:
# -> Token para prueba: "6d3a3c6d827c7875119893eeabfaa6c8e411cc1a"
# -> Token para produccion: 

class EstarConsumer

  include HTTParty

  URL_BASE  = 'http://ws.estarseguros.com:8899/test/wscot/ws.php'
  HEADER    = {"Content-Type" => "application/json" , "Accept" => "application/json"}
  AUTH      = { token: "6d3a3c6d827c7875119893eeabfaa6c8e411cc1a" }

  def initialize

  end

  class << self

    def send_get_request(path, params, header)
        begin
            response = HTTParty.get("#{URL_BASE}#{path}", :query => params)
            if response.code == 200
                return response.body
            else
                return JSON.generate({})
            end
        rescue HTTParty::Error
            return JSON.generate({ })
        rescue StandardError
            return JSON.generate({ })
        end
    end

    def cotizar_automovil(params)
      send_get_request("", AUTH.merge!(params), HEADER)
    end

    def parse(params)
        begin
            result_parse = JSON.parse(params)
        rescue StandardError
            result_parse = {}
        end
        result = {}
        result[:insurance] = "estar"

        result[:status] = 0
        result[:aire] = nil
        result[:responsabilidad] = nil
        result[:num_cotiza] = "N/A"
        result[:prima] = nil
        result[:cobertura] = nil
        result[:eventos] = nil
        result[:radio] = nil
        result[:muerte] = nil
        result[:invalidez] = nil
        result[:curacion] = nil
        result[:entierro] = nil
        result[:cosa_dan] = nil
        result[:personas_dan] = nil
        result[:exceso_cosa] = nil
        result[:exceso_persona] = nil
        result[:asistencia] = nil
        result[:cosa_dan] = nil

        #Falta guardar los datos correctos

        return result
    end



  end

end
