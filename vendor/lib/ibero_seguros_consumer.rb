require "active_support/all"
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

class IberoSegurosConsumer

  include HTTParty

  URL_BASE  = 'http://190.202.23.12/wsAsegurameIbero/cotizarAUTO'
  HEADER    = {"Content-Type" => "application/json" , "Accept" => "application/json"}
  AUTH      = { llave: "cm6oqnv9Sw" }

  def initialize

  end

  class << self

    def send_get_request(params, header)
        error = {}
        error["numero"] = "0"
        begin
            response = HTTParty.get("#{URL_BASE}", :query => params)
            if response.code == 200
                return response.body
            else
                error["error"] = "Código de respuesta: " + response.code.to_s
                return JSON.generate(error)
            end
        rescue HTTParty::Error
            error["error"] = "No se pudo conectar al API"
            return JSON.generate(error)
        rescue StandardError
            error["error"] = "Error desconocido"
            return JSON.generate(error)
        end
    end

    def cotizar_automovil(params)
      send_get_request( AUTH.merge!(params), HEADER)
    end

    def parse(params)
        begin
            result_parse = JSON.parse(params)
        rescue StandardError
            result_parse = {}
            result_parse["numero"] = "0"
        end
        result = {}
        result[:insurance] = "ibero"

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

        if result_parse["numero"].present? and not result_parse["numero"] == "0"
            result[:status] = 1
            result[:num_cotiza] = result_parse["numero"]
            for item in result_parse["cotizacion"]
                if item["cobertura"] == "Cobertura Amplia"
                    result[:cobertura] = item["suma"].to_f
                end
                if item["cobertura"] == "Motín Pérdida Total"
                    result[:eventos] = item["suma"].to_f
                end
                if item["cobertura"] == "Muerte"
                    result[:muerte] = item["suma"].to_f
                end
                if item["cobertura"] == "Invalidez Permanente"
                    result[:invalidez] = item["suma"].to_f
                end
                if item["cobertura"] == "Gastos Médicos a Terceros"
                    result[:curacion] = item["suma"].to_f
                end
                if item["cobertura"] == "R.C.V. Básica Cosas"
                    result[:cosa_dan] = item["suma"].to_f
                end
                if item["cobertura"] == "R.C.V. Básica Personas"
                    result[:personas_dan] = item["suma"].to_f
                end
                if item["cobertura"] == "Exceso de Límites"
                    result[:exceso_cosa] = item["suma"].to_f
                    result[:exceso_persona] = item["suma"].to_f
                end
                if item["cobertura"] == "Asistencia Legal y Defensa Penal"
                    result[:asistencia] = item["suma"].to_f
                end
                if item["cobertura"] == "Total Prima"
                    result[:prima] = item["prima"].to_f
                end
            end


        end
        return result
    end

  end


end
