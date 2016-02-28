require "active_support/all"
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

class OrientalConsumer

  include HTTParty

  URL_BASE  = 'http://enlinea.laoriental.com/portal/pls/portal/MOBILE_APP.LOS_WS_COTIZA_INICIO.show'
  HEADER    = {"Content-Type" => "application/json" , "Accept" => "application/json"}
  AUTH      = {"llave" => "YMA3CXKN771UE51", "metodo" => "WS_TARIFICACOTIZACION"}

  def initialize

  end

  class << self

    def send_request(params, header)

      error = {}
      error["estatus"] = "ERR"

      begin
          response = HTTParty.post("#{URL_BASE}", :body => { q: params } , :headers => header)
          if response.code == 200
              return response.body
          else
              error["msg"] = "Código de respuesta: " + response.code.to_s
              return JSON.generate(error)
          end
      rescue HTTParty::Error
          error["msg"] = "No se pudo conectar al API"
          return JSON.generate(error)
      rescue StandardError
          error["msg"] = "Error desconocido"
          return JSON.generate(error)
      end
    end

    def cotizar_automovil(params)
      send_request(
        AUTH.merge!(params).to_json,
        HEADER
      )
    end

    def parse(params)
        begin
            result_parse = JSON.parse(params)
        rescue StandardError
            result_parse = {}
            result_parse["estatus"] = "ERR"
        end
        result = {}
        result[:insurance] = "oriental"

        result[:status] = 0
        result[:aire] = nil
        result[:responsabilidad] = nil
        result[:num_cotiza] = "NA"
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
        
        if result[:versionList].nil?
          result[:versionList] = {}
        end
        if not (result_parse["estatus"].present? and result_parse["estatus"] == "ERR") and not result_parse["plan"].empty?
            result[:status] = 1
            result[:versionList] = result_parse
            for item in result_parse["plan"]
                if item["tipo"] == "Cobertura Amplia (Incluye Perdida total y Responsabilidad Civil)"
                    result[:num_cotiza] = item["nrocoti"]
                    result[:prima] = item["primatotal"].to_f
                    for cobertura in item["coberturas"]
                        if cobertura["nombre"] == "Cobertura Amplia"
                            result[:cobertura] = cobertura["suma"].gsub('.','').gsub(',','.').to_f
                        end
                        if cobertura["nombre"] == "(Motin, Dist. Callejeros, Inundacion y Daños Mali)"
                            result[:eventos] = cobertura["suma"].gsub('.','').gsub(',','.').to_f
                        end
                        if cobertura["nombre"] == "Muerte de Conductor y/o Pasajeros"
                            result[:muerte] = cobertura["suma"].gsub('.','').gsub(',','.').to_f
                        end
                        if cobertura["nombre"] == "Invalidez de Conductor y/o Pasajeros"
                            result[:invalidez] = cobertura["suma"].gsub('.','').gsub(',','.').to_f
                        end
                        if cobertura["nombre"] == "Gtos Medic  de Cond. y/o Pasj."
                            result[:curacion] = cobertura["suma"].gsub('.','').gsub(',','.').to_f
                        end
                        if cobertura["nombre"] == "Daños a Cosas"
                            result[:cosa_dan] = cobertura["suma"].gsub('.','').gsub(',','.').to_f
                        end
                        if cobertura["nombre"] == "Daños a Personas"
                            result[:personas_dan] = cobertura["suma"].gsub('.','').gsub(',','.').to_f
                        end
                        if cobertura["nombre"] == "Exceso de Limite"
                            result[:exceso_cosa] = cobertura["suma"].gsub('.','').gsub(',','.').to_f
                            result[:exceso_persona] = cobertura["suma"].gsub('.','').gsub(',','.').to_f
                        end
                        if cobertura["nombre"] == "Defensa Penal"
                            result[:asistencia] = cobertura["suma"].gsub('.','').gsub(',','.').to_f
                        end
                    end
                end
            end
        end
        return result
    end
  end
end
