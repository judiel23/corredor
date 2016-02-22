require "active_support/all"
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

class VivirSegurosConsumer

  include HTTParty

  URL_BASE  = 'http://online.vivirseguros.web.ve/vivirCotiza/servicios'
  HEADER    = {"Content-Type" => "application/json" , "Accept" => "application/json"}

  def initialize

  end

  class << self

    def send_get_request(path, params, header)
      error = {}
      error["numero"] = "0"
      error["idError"] = "INTERNAL-1"
      begin
          response = HTTParty.get("#{URL_BASE}#{path}", :query => params)
          if response.code == 200
              return response.body
          else
              error["mensajeError"] = "Código de respuesta: " + response.code.to_s
              return JSON.generate(error)
          end
      rescue HTTParty::Error
          error["mensajeError"] = "No se pudo conectar al API"
          return JSON.generate(error)
      rescue StandardError
          error["mensajeError"] = "Error desconocido"
          return JSON.generate(error)
      end
    end

    def cotizar_automovil(params)
      send_get_request("/cotizarAUTO/",params,HEADER)
    end

    def parse(params)
        begin
            result_parse = JSON.parse(params)
        rescue StandardError
            result_parse = {}
            result_parse["numero"] = "0"
            result_parse["idError"] = "INTERNAL-1"
        end
        result = {}
        result[:insurance] = "vivir"

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

        if not result_parse["numero"] == nil and not result_parse["numero"] == "0"
            result[:status] = 1
            result[:num_cotiza] = result_parse["numero"]
            for item in result_parse["cotizacion"]
                if item["cobertura"] == "COBERTURA AMPLIA / MOTIN Y/O DISTURBIOS
CALLEJEROS"
                    result[:cobertura] = item["suma"].to_f
                end
                if item["cobertura"] == "EVENTOS CATASTROFICOS"
                    result[:eventos] = item["suma"].to_f
                end
                if item["cobertura"] == "MUERTE DE CONDUCTOR Y/O PASAJEROS"
                    result[:muerte] = item["suma"].to_f
                end
                if item["cobertura"] == "INVALIDEZ DE CONDUCTOR Y/O PASAJEROS"
                    result[:invalidez] = item["suma"].to_f
                end
                if item["cobertura"] == "GASTOS MEDICOS DE CONDUCTOR Y/O PASAJEROS"
                    result[:curacion] = item["suma"].to_f
                end
                if item["cobertura"] == "FUNERARIO MERCADEO MASIVO"
                    result[:entierro] = item["suma"].to_f
                end
                if item["cobertura"] == "DANOS A COSAS"
                    result[:cosa_dan] = item["suma"].to_f
                end
                if item["cobertura"] == "DANOS A PERSONAS"
                    result[:personas_dan] = item["suma"].to_f
                end
                if item["cobertura"] == "EXCESO DE LIMITE"
                    result[:exceso_cosa] = item["suma"].to_f
                    result[:exceso_persona] = item["suma"].to_f
                end
                if item["cobertura"] == "DEFENSA PENAL"
                    result[:asistencia] = item["suma"].to_f
                end
                if item["cobertura"] == "TOTAL PRIMA"
                    result[:prima] = item["prima"].to_f
                end
            end


        end
        return result
    end


  end
end
