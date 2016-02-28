require "active_support/all"
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

class UniversitasConsumer

  include HTTParty

  URL_BASE  = 'http://inspeccionqa.segurosuniversitas.com:8080/UniServiciosWeb/servicio/automovil'
  HEADER    = {"Content-Type" => "application/json" , "Accept" => "application/json"}
  AUTH      = {'codusr' => 'ferna01', 'pass' => 'RmVybmFuZG8wMQ=='}

  def initialize

  end

  class << self

    def send_request(path, params, header)
      error = {}
      error[:pcursor] = [[{}]]
      error[:pcursor][0][0]["coderror"] = "Internal"
      begin
          response = HTTParty.post("#{URL_BASE}#{path}", :body => params, :headers => header)
          if response.code == 200
              return response.body
          else
              error["pcursor"][0][0]["msg"] = "Código de respuesta: " + response.code.to_s
              return JSON.generate(error)
          end
      rescue HTTParty::Error
          error["pcursor"][0][0]["msg"] = "No se pudo conectar al API"
          return JSON.generate(error)
      rescue StandardError
          error["pcursor"][0][0]["msg"] = "Error desconocido"
          return JSON.generate(error)
      end

    end

    def get_marcas(anio)
      send_request(
        "/marca_veh/",
        AUTH.merge!({'anoveh' => anio.to_i }).to_json,
        HEADER
      )
    end

    def get_modelo(anio, marca)
      send_request(
        "/modelo_veh/",
        AUTH.merge!({'anoveh' => anio.to_i, 'codmarca' => marca}).to_json,
        HEADER
      )
    end

    def get_version(anio, marca, modelo)
      send_request(
        "/version_veh/",
        AUTH.merge!({'anoveh' => anio.to_i, 'codmarca' => marca, 'codmodelo' => modelo}).to_json,
        HEADER
      )
    end

    def cotizar_automovil(params)
      send_request(
        "/cotiza_auto/",
        AUTH.merge!(params).to_json,
        HEADER
      )
    end

    def parse(params)
        begin
            result_parse = JSON.parse(params)
        rescue StandardError
            result_parse = {}
            result_parse[:pcursor] = [[{}]]
            result_parse[:pcursor][0][0]["coderror"] = "Internal"
        end
        result = {}
        result[:insurance] = "universitas"

        result[:status] = 0
        result[:aire] = nil
        result[:responsabilidad] = nil
        result[:num_cotiza] = "N/A"
        result[:prima] = nil
        result[:cobertura] = nil
        result[:eventos] = nil
        result[:radio] = nil
        result[:responsabilidad] = nil
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

        if result_parse["pcursor"].present? and not result_parse["pcursor"][0][0]["coderror"].present?
            result[:status] = 1
            result[:num_cotiza] = result_parse["numcotizacion"]
            prima = 0
            for item in result_parse["pcursor"][0]
                if (item["mtoprima"] != "" && item["descripcion"] != "Accesorios Originales")
                    prima += item["mtoprima"].gsub('.','').gsub(',','.').to_f
                end
                if item["descripcion"] == "Cobertura Amplia"
                    result[:cobertura] = item["mtosumaaseg"].gsub('.','').gsub(',','.').to_f
                end
                if item["descripcion"] == "Cobertura Catastrofica"
                    result[:eventos] = item["mtosumaaseg"].gsub('.','').gsub(',','.').to_f
                end
                if item["descripcion"] == "Accesorios Originales"
                    result[:radio] = item["mtosumaaseg"].gsub('.','').gsub(',','.').to_f
                end
                if item["descripcion"] == "Muerte Accidental Conductor"
                    result[:muerte] = item["mtosumaaseg"].gsub('.','').gsub(',','.').to_f
                end
                if item["descripcion"] == "Invalidez Permanente Conductor"
                    result[:invalidez] = item["mtosumaaseg"].gsub('.','').gsub(',','.').to_f
                end
                if item["descripcion"] == "Gastos Medicos Conductor"
                    result[:curacion] = item["mtosumaaseg"].gsub('.','').gsub(',','.').to_f
                end
                if item["descripcion"] == "Gastos Funerarios Conductor"
                    result[:entierro] = item["mtosumaaseg"].gsub('.','').gsub(',','.').to_f
                end
                if item["descripcion"] == "Daños A Cosas"
                    result[:cosa_dan] = item["mtosumaaseg"].gsub('.','').gsub(',','.').to_f
                end
                if item["descripcion"] == "Daños A Personas"
                    result[:personas_dan] = item["mtosumaaseg"].gsub('.','').gsub(',','.').to_f
                end
                if item["descripcion"] == "Exceso De Limite"
                    result[:exceso_cosa] = item["mtosumaaseg"].gsub('.','').gsub(',','.').to_f
                    result[:exceso_persona] = item["mtosumaaseg"].gsub('.','').gsub(',','.').to_f
                end
                if item["descripcion"] == "Defensa Penal"
                    result[:asistencia] = item["mtosumaaseg"].gsub('.','').gsub(',','.').to_f
                end
                if item["descripcion"] == "Daños A Cosas"
                    result[:cosa_dan] = item["mtosumaaseg"].gsub('.','').gsub(',','.').to_f
                end
            end
            result[:prima] = prima
        end
        return result

    end
  end
end
