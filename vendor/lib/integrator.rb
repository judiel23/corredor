require "active_support/all"
# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

class Integrator

  @integrate_params = {}

  def initialize

  end

  class << self

    def reset_params
      @integrate_params = {}
    end

    def prepare_params_for_universitas(params)
      reset_params
      @integrate_params.merge!({
          desnombre:        params[:name],
          desapellido:      params[:lastname],
          rif:              params[:dni_number],
          codarealocal:     params[:local_code_area],
          numtelefonolocal: params[:local_phone],
          codareacel:       params[:movil_code_area],
          numtelefcel:      params[:movil_phone],
          fecnac:           params[:birthday],
          codedocivil:      params[:marital_status],
          codsexo:          params[:sex],
          email:            params[:email],
          anoveh:           params[:vehicle_year],
          codmarca:         params[:vehicle_brand],
          codmodelo:        params[:vehicle_model],
          codversion:       params[:vehicle_version],
          codinter:         params[:intermediate_code],
          codestado:        params[:state],
          codplan:          params[:plan_code],
          revplan:          params[:plan_review],
          porcdcto:         params[:discount_rate]
      })
    end

    def prepare_params_for_vivir(params)
      reset_params
      @integrate_params.merge!({
          ano:              params[:vehicle_year],
          civi:             "#{params[:vehicle_brand]}#{params[:vehicle_model]}#{params[:vehicle_version]}",
          sexo:             params[:sex],
          edocivil:         params[:marital_status],
          fnacimiento:      params[:birthday].gsub("-", "/"), #"dd/mm/yyyy"
          estado:           (params[:state].to_i + 100).to_s,
          plan:             "10000001", # params[:plan_code],
          nacionalidad:     params[:dni_type],
          cedularif:        params[:dni_number],
          nombre:           params[:name],
          apellido:         params[:lastname],
          cdareaFijo:       params[:local_code_area],
          nutelefonoFijo:   params[:local_phone],
          cdareaCel:        params[:movil_code_area],
          nutelefonoCel:    params[:movil_phone],
          email:            params[:email],
          usoveh:           params[:vehicle_use].to_s,
          cerokm:           params[:kilometer_zero],
          tipoveh:          params[:vehicle_type].to_s,
          cdProductor:      "22642"
      })
    end

    def prepare_params_for_oriental(params)
      reset_params
      @integrate_params.merge!({
          codinter:         params[:intermediate_code], # "005085"
          nacionalidad:     params[:dni_type],
          cedulacli:        params[:dni_number],
          nombrecli:        params[:name],
          apecli:           params[:lastname],
          fechanaccli:      params[:birthday].gsub("-", "/"),
          emailcli:         params[:email],
          telefcli:         "#{params[:local_code_area]}#{params[:local_phone]}" ,
          edocivilcli:      params[:marital_status],
          sexocli:          params[:sex],
          edoriesgocli:     params[:state],
          marca:            params[:vehicle_brand],
          modelo:           params[:vehicle_model],
          version:          params[:vehicle_version],
          anoveh:           params[:vehicle_year],
          placa:            params[:plaque],
          # Adicional
          nacionalidadi:    params[:dni_type],
          cedulacliadi:     params[:dni_number],
          nombrecliadi:     params[:name],
          apecliadi:        params[:lastname],
          fechanaccliadi:   params[:birthday].gsub("-", "/"),
          edocivilcliadi:   params[:marital_status],
          sexocliadi:       params[:sex]
          #
      })
    end


     def prepare_params_for_ibero(params)
      reset_params
      @integrate_params.merge!({
        ano:                params[:vehicle_year],
        civi:               "#{params[:vehicle_brand]}#{params[:vehicle_model]}#{params[:vehicle_version]}",
        sexo:               params[:sex],
        edocivil:           params[:marital_status],
        fnacimiento:        params[:birthday].gsub("-", "/"),
        estado:             params[:state],
        plan:               "1",
        nacionalidad:       params[:dni_type],
        cedularif:          params[:dni_number],
        nombre:             params[:name],
        apellido:           params[:lastname],
        cdarea:             "0#{params[:local_code_area]}",
        nutelefono:         params[:local_phone],
        email:              params[:email],
        aliado:             "20544", # 20544
        sumaseg:            params[:sumaAsegurada]

      })

    end

    def prepare_params_for_sumaAsegurada_ibero(params)
      reset_params
      @integrate_params.merge!({
        ano:            params[:vehicle_year],            
        civi:           "#{params[:vehicle_brand]}#{params[:vehicle_model]}#{params[:vehicle_version]}",
        aliado:         "20544",
        })
    end


def prepare_params_for_estar(params)
      reset_params
      @integrate_params.merge!({
        nom:                params[:name],
        ape:                params[:lastname],
        td:                 params[:dni_type],
        nd:                 params[:dni_number],
        fn:                 params[:birthday].gsub("-", ""),
        tlf:                "0#{params[:local_code_area]}#{params[:local_phone]}",
        cel:                "0#{params[:movil_code_area]}#{params[:movil_phone]}",
        ec:                 params[:marital_status],
        s:                  params[:sex],
        em:                 params[:email],
        civi:               "#{params[:vehicle_brand]}#{params[:vehicle_model]}#{params[:vehicle_version]}",
        a:                  params[:vehicle_year],
        placa:              params[:plaque],
        zc:                 params[:state],
        u:                  "1",
        b:                  "0",
        vm:                 "1", # Valor de Mercado Adicional 1 => INMA | 1.2 => INMA + 20% | 1.3 => INMA + 30%
        op:                 "2" # 3 => Solicitud con Datos Limitados | 2 => Solicitud con Datos del Cliente Completos
      })
    end


    def call_cotizar_universitas_auto(params)
      prepare_params_for_universitas(params)
      UniversitasConsumer::cotizar_automovil(@integrate_params)
    end

    def call_cotizar_vivir_auto(params)
      prepare_params_for_vivir(params)
      VivirSegurosConsumer::cotizar_automovil(@integrate_params)
    end

    def call_cotizar_oriental_auto(params)
      prepare_params_for_oriental(params)
      OrientalConsumer::cotizar_automovil(@integrate_params)
    end

    def call_cotizar_ibero_auto(params)
      prepare_params_for_ibero(params)
      IberoSegurosConsumer::cotizar_automovil(@integrate_params)
    end

    def call_sumaAsegurada_ibero(params)
      prepare_params_for_sumaAsegurada_ibero(params)
      IberoSegurosSuma::sumaAsegurada_automovil(@integrate_params) rescue nil 
    end

    def call_cotizar_estar_auto(params)
      prepare_params_for_estar(params)
      EstarConsumer::cotizar_automovil(@integrate_params)
    end

    def age(dob)
      now = Time.now.utc.to_date
      now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
    end

  end


end
