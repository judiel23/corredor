require "selenium-webdriver"
require "test/unit"
require "csv"


class GoogleSearch < Test::Unit::TestCase
  def setup
    @driver = Selenium::WebDriver.for :firefox
    @base_url = "http://localhost:3000/"
    @driver.manage.timeouts.implicit_wait = 1000
    @verification_errors = []
  end

  def teardown
    @driver.quit
    assert_equal [], @verification_errors
  end
  def test_google_search

    # Se abre el documento donde se guardará el resultado.
    cotizResult = CSV.open('cotizResult.csv','w')
    cotizResult << ['ID', 'MARCA', 'MODELO ', 'AÑO','VERSION','RESULT_UNIV', 'RESULT_VIVIR', 'RESULT_ESTAR', 'RESULT_ORIENTAL', 'RESULT_IBERO']

    @driver.get(@base_url)
    @driver.find_element(:id , "user_email").send_keys "edwardfernandez26@gmail.com"
    @driver.find_element(:id , "user_password").send_keys "Edward_21"
    @driver.find_element(:name , "commit").click
    sleep 1

    verificando = true  
    idVehiculo = 1
    idModel = 0
    idYear  = 0
    idVersion = 0
    i = 1

    wait = Selenium::WebDriver::Wait.new(:timeout => 60) 

    while verificando

      @driver.navigate().to("http://localhost:3000/corredors/new");
      sleep 1

      # Se elije el vehículo.
      @driver.find_element(:name, "corredor[marca]").click
      sleep 1

      vehiculos = @driver.find_elements(:class , "select2-results__option")

      if idVehiculo < vehiculos.size()
        marcaVeh = vehiculos[idVehiculo].attribute("innerHTML")
        @driver.find_element(:class, "select2-search__field").send_keys marcaVeh
        @driver.find_element(:class, "select2-search__field").send_keys:return
        sleep 1
        @driver.find_element(:name , "commit").click

        if idVehiculo == vehiculos.size()
          verificando = false
        end
      end

      # Se elije el modelo del carro.
      model = @driver.find_elements(:name, "corredor[modelo]")
        
        if idModel < model.size()
          sleep 1


          modelVeh = @driver.find_elements(:class , "list-group-item")
          modelVeh = modelVeh[idModel].attribute("innerHTML")
          modelVeh =  modelVeh.split(">")[-1].split("  ")[-1].split("\n")[0]
          model[idModel].click
          
          if idModel == model.size()
            idModel = 0
            idVehiculo = idVehiculo + 1
          end
        end

      # Se elije el año del vehiculo.
      year = @driver.find_elements(:name, "corredor[year]")
        if idYear < year.size()
          sleep 1

          yearVeh = @driver.find_elements(:class , "list-group-item")
          yearVeh = yearVeh[idYear].attribute("innerHTML")
          yearVeh = yearVeh.split(">")[-1]
          year[idYear].click

          if idYear == year.size()
            idYear = 0
            idModel = idModel + 1
          end
        end

      # Se elije la versión del vehiculo.
      version = @driver.find_elements(:name, "corredor[version]")
        if idVersion < version.size()
          sleep 1

          versionVeh = @driver.find_elements(:class , "list-group-item")
          versionVeh = versionVeh[idVersion].attribute("innerHTML")
          versionVeh = versionVeh.split(">")[-1].split("  ")[-1].split("\n")[0]

          version[idVersion].click
          idVersion = idVersion + 1
        end

      # Se llena el campo "Placa".
      @driver.find_element(:name , "corredor[placa]").send_keys "MFL03S"
      @driver.find_element(:name , "commit").click
      sleep 1

      # Se elije el estado.
      @driver.find_element(:id, "select2-estados-container").click
      @driver.find_element(:class, "select2-search__field").send_keys "Amazonas"
      @driver.find_element(:class, "select2-search__field").send_keys:return
      sleep 1

      # Se coloca la cedula del asegurado.
      @driver.find_element(:name , "corredor[cedula]").send_keys "21099355"
      @driver.find_element(:name , "commit").click
      sleep 1

      # Se coloca el nombre y el apellido del asegurado.
      @driver.find_element(:name , "corredor[nombre]").send_keys "Edward"
      @driver.find_element(:name , "corredor[apellido]").send_keys "Fernández"
      @driver.find_element(:name , "commit").click
      sleep 1

      # Se elije el sexo.
      @driver.find_element(:xpath , "//img[@alt='Masculino']").click
      sleep 1

      # Se coloca el correo del asegurado.
      @driver.find_element(:name , "corredor[email]").send_keys "edwardfernandez26@gmail.com"
      @driver.find_element(:name , "commit").click
      sleep 1

      # Se elije el estado civil.
      @driver.find_element(:xpath , "//img[@alt='Soltero']").click
      sleep 1

      # Se elije la fecha de nacimiento.
      @driver.find_element(:xpath , "//label[@for='03']").click
      @driver.find_element(:xpath, "//label[@for='jan']").click
      @driver.find_element(:xpath , "//label[@for='1994']").click
      @driver.find_element(:name , "commit").click
      sleep 1 

      # Se coloca el teléfono de casa del asegurado.
      @driver.find_element(:name , "corredor[cedula]").send_keys "02691962"
      @driver.find_element(:name , "commit").click
      sleep 1

      # Se coloca el teléfono movil del asegurado.
      @driver.find_element(:name , "corredor[tcelular]").send_keys "3145995"
      @driver.find_element(:name , "commit").click
      sleep 30


      wait.until { @driver.find_element(:id , "resulset_universitas") }
      resultUniv = @driver.find_element(:id, "resulset_universitas").attribute("innerHTML")
      resultUniv = resultUniv.split("</b>")[-1][1..-1][0..-5]

      wait.until { @driver.find_element(:id , "resulset_vivir") }
      resultVivir = @driver.find_element(:id, "resulset_vivir").attribute("innerHTML")
      resultVivir = resultVivir.split("</b>")[-1].split("<br>")[0][1..-1]
      #resultEstar = @driver.find_element(:id, "resulset_estar").attribute("innerHTML")

      wait.until { @driver.find_element(:id , "resulset_ibero") }
      resultIbero = @driver.find_element(:id, "resulset_ibero").attribute("innerHTML")
      resultIbero = resultIbero.split("</b>")[-1][1..-5]

      if resultVivir == "null"
        resultVivir = "undefined"
      end

      if resultIbero == "0"
        resultIbero = "undefined"
      end 


      cotizResult << [i, marcaVeh, modelVeh, yearVeh, versionVeh, resultUniv, resultVivir, "undefined", "undefined", resultIbero]
      i = i + 1


      if idVersion == version.size()
        idVersion = 0
        idYear = idYear + 1
      end

    end
  end

end