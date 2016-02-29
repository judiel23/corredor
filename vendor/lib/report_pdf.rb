"""
  Se comentaron las otras aseguradoras ya que Oriental estará en Produccíón.
  NO TOCAR.

  * Se cambió @fallouniversitas, @fallovivir, @falloestar y @falloibero a true
    ya que no se deben mostrar actualemte.

"""


# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

class ReportPdf < Prawn::Document
  def initialize(quotes)
    super( :page_layout => :landscape)
    @quotes = quotes
    @dic = @dic

    @marca   = Make.find_by(:code => @quotes.marca).make
    @modelo  = Vehicle.find_by(:make => @quotes.marca, :code => @quotes.modelo).model

    #@universitas = Report.where(:corredor_id => @quotes.id, :insurance => "universitas").last
    @vivir = Report.where(:corredor_id => @quotes.id, :insurance => "vivir").last
    @oriental = Report.where(:corredor_id => @quotes.id, :insurance => "oriental").last

    if @quotes.sexo == "F"
      @sexo = "Femenino"
    else
      @sexo = "Masculino"
    end

    case @quotes.estado
      when "D"
        if @sexo == "Masculino"
            @estadoCivil = "DIVORCIADO"
        else
            @estadoCivil = "DIVORCIADA"
        end
      when "S"
        if @sexo == "Masculino"
            @estadoCivil = "SOLTERO"
        else
            @estadoCivil = "SOLTERA"
        end
      when "C"
        if @sexo == "Masculino"
            @estadoCivil = "CASADO"
        else
            @estadoCivil = "CASADA"
        end
      else
        if @sexo == "Masculino"
            @estadoCivil = "VIUDO"
        else
            @estadoCivil = "VIUDA"
        end
    end

    puts @oriental.actualCoti.to_json
    if @oriental.actualCoti != nil
      @orientalActualCoti = JSON.parse(@oriental.actualCoti)
      @vehicle_information = @orientalActualCoti["version"]
      @plan_information = @orientalActualCoti["plan"]
    else

        @orientalActualCoti = {}

        if @oriental.num_cotiza == "NA"
          @orientalActualCoti["status"] = "NA"
          puts "curacion"
          @orientalActualCoti["aire"] = "NA"
          @orientalActualCoti["responsabilidad"] = "NA"
          @orientalActualCoti["num_cotiza"] = "NA"
          @orientalActualCoti["prima"] = "NA"
          @orientalActualCoti["cobertura"] = "NA"
          @orientalActualCoti["eventos"] = "NA"
          @orientalActualCoti["radio"] = "NA"
          @orientalActualCoti["muerte"] = "NA"
          @orientalActualCoti["invalidez"] = "NA"
          @orientalActualCoti["curacion"] = "NA"
          @orientalActualCoti["entierro"] = "NA"
          @orientalActualCoti["cosa_dan"] = "NA"
          @orientalActualCoti["personas_dan"] = "NA"
          @orientalActualCoti["exceso_cosa"] = "NA"
          @orientalActualCoti["exceso_persona"] = "NA"
          @orientalActualCoti["asistencia"] = "NA"
        else
          @orientalActualCoti["status"] = @oriental.status
          puts "curacion"
          @orientalActualCoti["aire"] = @oriental.aire
          @orientalActualCoti["responsabilidad"] = @oriental.responsabilidad
          @orientalActualCoti["num_cotiza"] = @oriental.num_cotiza
          @orientalActualCoti["prima"] = @oriental.prima
          @orientalActualCoti["cobertura"] = @oriental.cobertura
          @orientalActualCoti["eventos"] = @oriental.eventos
          @orientalActualCoti["radio"] = @oriental.radio
          @orientalActualCoti["muerte"] = @oriental.muerte
          @orientalActualCoti["invalidez"] = @oriental.invalidez
          @orientalActualCoti["curacion"] = @oriental.curacion
          @orientalActualCoti["entierro"] = @oriental.entierro
          @orientalActualCoti["cosa_dan"] = @oriental.cosa_dan
          @orientalActualCoti["personas_dan"] = @oriental.personas_dan
          @orientalActualCoti["exceso_cosa"] = @oriental.exceso_cosa
          @orientalActualCoti["exceso_persona"] = @oriental.exceso_persona
          @orientalActualCoti["asistencia"] = @oriental.asistencia
        end

        @version = Version.find_by(:make => @quotes.marca, :model => @quotes.modelo, :code => @quotes.version).version
        @vehicle_information = @modelo + " " + @version
    end

    @vehicle_information = @vehicle_information.force_encoding('cp1252')
    puts @orientalActualCoti
    #@ibero = Report.where(:corredor_id => @quotes.id, :insurance => "ibero").last
    #@estar = Report.where(:corredor_id => @quotes.id, :insurance => "estar").last

    puts "---------------"
    puts "hola"
    puts @oriental

    @estados = ["","Amazonas","Anzoategui", "Apure", "Aragua","Barinas","Bolivar","Carabobo",
               "Cojedes","Delta Amacuro", "Distrito Capital", "Falcon", "Guarico", "Lara",
               "Merida", "Miranda", "Monagas", "Nueva Esparta", "Portuguesa", "Sucre",
               "Tachira", " Trujillo", "Vargas", "Yaracuy", "Zulia"]



    @nombre = @quotes.nombre.capitalize
    @apellido = @quotes.apellido.capitalize

    @fallouniversitas = true
    @fallovivir = true
    @fallooriental = false
    @falloibero = true
    @falloestar = true

    #if @universitas == nil or @universitas.status == '0'
    #  @fallouniversitas = true
    #end

    if @vivir == nil
     @fallovivir = true
    end

    if @oriental == nil
      @fallooriental = true
    end

    #if @ibero == nil or @ibero.status == '0'
    #  @falloibero = true
    #end

    #if @estar == nil or @estar.status == '0'
    #  @falloestar = true
    #end

    header
    table_content

    page_layout = :landscape

  end

  def comma_numbers(number, delimiter = ',')
              number.to_s.reverse.gsub(%r{([0-9]{3}(?=([0-9])))}, "\\1#{delimiter}").reverse
          end

  def header
    #This inserts an image in the pdf file and sets the size of the image
    #image "#{Rails.root}/app/assets/images/header.jpg", width: 530, height: 150

        move_down 40

        bounding_box([420, 550], :width => 400, :height => 50) do
          formatted_text_box([{ :text => "Cotización Seguro de Auto",
                                :size => 24,
                                :align => :right,
                                :color => '30559D',
                                :styles => [:bold, :italic],
                                :at => [395, 510] }])
        end

          move_down 40

          logo = "#{Rails.root}/app/assets/images/logojohan.jpg"
          image logo, :at => [9,550], :width => 250

          draw_text "Fecha: #{Time.now.strftime("%d/%m/%Y")}",  :size => 11, :style => :bold, :at => [480, 500]


        bounding_box([610, 510], :width => 400, :height => 50, :padding => 0) do
          formatted_text_box([{ :text => "Válido por 7 Días",
                                :size => 14,
                                :align => :right,
                                :color => '30559D',
                                :styles => [:bold, :italic],
                                :at => [395, 510] }])
        end


        bounding_box([0, 390], :width => 200, :height => 50, :padding => 0) do
          formatted_text_box([{ :text => "www.corredorleal.com",
                                :size => 14,
                                :align => :right,
                                :color => '30559D',
                                :styles => [:bold, :italic],
                                :at => [395, 390] }])
        end

        #  draw_text "Válido por 7 Días",                 :size => 9, :style => :bold, :style => :bold, :at => [653, 480], :size => 12
          draw_text "gerencia@corredorleal.com",         :size => 9, :at => [01,   430]
          draw_text "(0212) 716-5154 / (0212) 424-1266", :size => 9, :at => [125, 430]
          draw_text "presidencia@corredorleal.com",      :size => 9, :at => [01,   410]
          draw_text "(0414) 249-6264 / (0424) 177-3968", :size => 9, :at => [125, 410]

         move_down 90

         if @fallouniversitas && @fallovivir && @fallooriental && @falloibero && @falloestar

            draw_text "No se pudo realizar ninguna cotización",             :style => :bold, :size => 30, :at => [150, 200], :color => "30559D"
         end


  end



    def prima_numbers(number, delimiter = '.')
      number.to_s.reverse.gsub(%r{([0-9]{3}(?=([0-9])))}, "\\1#{delimiter}").sub(/\./, ',').reverse
  end

  def comma_numbers(number, delimiter = ',')
              number.to_s.reverse.gsub(%r{([0-9]{3}(?=([0-9])))}, "\\1#{delimiter}").reverse
          end




  def text_content
    # The cursor for inserting content starts on the top left of the page. Here we move it down a little to create more space between the text and the image inserted above
    y_position = cursor - 50

    # The bounding_box takes the x and y coordinates for positioning its content and some options to style it
    bounding_box([0, y_position], :width => 270, :height => 300) do
      text "Lorem ipsum", size: 15, style: :bold
      text "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse interdum semper placerat. Aenean mattis fringilla risus ut fermentum. Fusce posuere dictum venenatis. Aliquam id tincidunt ante, eu pretium eros. Sed eget risus a nisl aliquet scelerisque sit amet id nisi. Praesent porta molestie ipsum, ac commodo erat hendrerit nec. Nullam interdum ipsum a quam euismod, at consequat libero bibendum. Nam at nulla fermentum, congue lectus ut, pulvinar nisl. Curabitur consectetur quis libero id laoreet. Fusce dictum metus et orci pretium, vel imperdiet est viverra. Morbi vitae libero in tortor mattis commodo. Ut sodales libero erat, at gravida enim rhoncus ut."
    end

    bounding_box([300, y_position], :width => 270, :height => 300) do
      text "Duis vel", size: 15, style: :bold
      text "Duis vel tortor elementum, ultrices tortor vel, accumsan dui. Nullam in dolor rutrum, gravida turpis eu, vestibulum lectus. Pellentesque aliquet dignissim justo ut fringilla. Interdum et malesuada fames ac ante ipsum primis in faucibus. Ut venenatis massa non eros venenatis aliquet. Suspendisse potenti. Mauris sed tincidunt mauris, et vulputate risus. Aliquam eget nibh at erat dignissim aliquam non et risus. Fusce mattis neque id diam pulvinar, fermentum luctus enim porttitor. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos."
    end

  end

  def table_content
    # This makes a call to product_rows and gets back an array of data that will populate the columns and rows of a table
    # I then included some styling to include a header and make its text bold. I made the row background colors alternate between grey and white
    # Then I set the table column widths


    bounding_box([320,385], :width => 400, :height => 120) do
      table vehicle_info do
        row(0).font_style = :bold
        self.column_widths = [120, 160,120]
        self.cell_style = {:size => 10, :height => 15, :align => :center, :padding => 2}
      end
    end

    bounding_box([480, 485], :width => 300, :height => 150) do
      table client_info do
        column(0).font_style = :bold
        self.column_widths = [120, 120]
        self.cell_style = {:size => 10, :height => 15, :align => :center, :padding => 3}
      end
    end

    column = [170]
    color = ['999999']

    if !@fallouniversitas
        column.push(110)
        color.push('22A7F0')
    end

    if !@fallovivir
        column.push(110)
        color.push('E87E04')
    end

    if !@falloestar
        column.push(110)
        color.push('AEA8D3')
    end

    if !@fallooriental
        #column.push(110)
        column.push(550)
        color.push('F7CA18')
    end

    if !@falloibero
        column.push(110)
        color.push('2ECC71')
    end


  bounding_box([0, 345], :width => 730) do
    table headers do
      row(0).font_style = :bold
      self.column_widths = column
      self.cell_style = {:size => 9, :height => 18, :align => :center, :padding => 3}
      for i in 0 ... color.size
          column(i).style :background_color => color[i]
      end
     end
    end


    table quote_rows do
      self.row_colors = ['DDDDDD', 'FFFFFF']
      self.column_widths = column
      self.cell_style = {:size => 10, :height => 18, :align => :center, :padding => 3}
      column(0).row(0..-2).style(:size => 9, :font_style => :bold, :align => :left)
      row(5).column(1..-1).font_style = :bold
      row(5).style :background_color => 'ADAD85'
      row(16).style :background_color => 'D3D3D3'
      for i in 0 ... color.size
          row(16).column(i).style(:background_color => color[i], :font_style => :bold)
      end
    end


    table footer do
      self.column_widths = [720]
      column(0).style :background_color => 'FFFF00'
      self.cell_style = {:size => 12, :height => 20, :align => :center, :padding => 3}
    end

  end




  def vehicle_info
    [
      ['Marca', 'Modelo', 'Año'],
      [@marca,  @vehicle_information , @quotes.year],
    ]
  end

  def client_info
    [
      ['Nombre', (@nombre + " " + @apellido).upcase],
      ['Cedula', comma_numbers(@quotes.cedula, ".")],
      ['Sexo', @sexo.upcase],
      ['Estado Civil', @estadoCivil],
      ['Fecha de Nacimiento:', @quotes.fnacimiento],
      ['Circulacion:', @estados[@quotes.zona.to_i].upcase],
    ]
  end

  def headers

    @header = ['Coberturas']

     if !@fallouniversitas
        @header.push('Seguros Universitas')
    end

    if !@fallovivir
       @header.push('Vivir Seguros')
    end

    if !@falloestar
       @header.push('Estar Seguros')
    end

    if !@fallooriental
       @header.push('La Oriental de Seguros')
    end

    if !@falloibero
        @header.push('Ibero Seguros')
    end

    [
       @header
    ]
  end

  def quote_rows

    @na = "NA"
    @cotizacion = ["N° de Cotizacion"]
    @cobertura = ["Cobertura Amplia"]
    @eventos = ["Eventos Catastróficos"]
    @aire = ["Aire Acondicionado"]
    @radio = ["Radio, CD, MP3, DVD (con Pantalla)"]
    @grua =["Servicio de Grua"]
    @responsabilidad = ["Responsabilidad Civil/APOV"]
    @muerte = ["Muerte Conductor/Pasajeros"]
    @invalidez = ["Invalidez Conductor/Pasajeros"]
    @curacion = ["Gastos de Curación Conductor/Pasajeros"]
    @entierro = ["Gastos de Entierro Conductor/Pasajeros"]
    @cosa = ["Daños a Cosas"]
    @persona = ["Daños a Personas"]
    @lcosa = ["Exceso de Límite a Cosas"]
    @lpersona = ["Exceso de Límite a Personas"]
    @asistencia = ["Asistencia Legal y Defensa Penal"]
    @prima = ["TOTAL PRIMA"]


    if !@fallooriental
        @cotizacion.push(@orientalActualCoti["num_cotiza"])
        @cobertura.push(@orientalActualCoti["cobertura"])
        @eventos.push(@orientalActualCoti["eventos"])
        @aire.push(@orientalActualCoti["aire"])
        @radio.push(@orientalActualCoti["radio"])
        @grua.push("CONTRATADO")
        @responsabilidad.push("")
        @muerte.push(@orientalActualCoti["muerte"])
        @invalidez.push(@orientalActualCoti["invalidez"])
        @curacion.push(@orientalActualCoti["curacion"])
        @entierro.push(@orientalActualCoti["entierro"])
        @cosa.push(@orientalActualCoti["cosa_dan"])
        @persona.push(@orientalActualCoti["personas_dan"])
        @lcosa.push(@orientalActualCoti["exceso_cosa"])
        @lpersona.push(@orientalActualCoti["exceso_persona"])
        @asistencia.push(@orientalActualCoti["asistencia"])
        if (@orientalActualCoti['prima']== "NA")
          @prima.push(@orientalActualCoti["prima"])
        else
          @prima.push( comma_numbers(('%.2f' % @orientalActualCoti["prima"]).to_s.gsub('.', ','),"."))
        end
    end

    [
        @cobertura,
        @eventos,
        @aire,
        @radio,
        @grua,
        @responsabilidad,
        @muerte,
        @invalidez,
        @curacion,
        @entierro,
        @cosa,
        @persona,
        @lcosa,
        @lpersona,
        @asistencia,
        @prima,
        @cotizacion,

    ]
  end

    def footer
    [
      ['NOTA: Esta cotizacion no aplica en el caso de que el vehiculo ya se encuentre asegurado en alguna de las compañias aseguradoras arriba mencionadas']
    ]
  end

 end