json.array!(@corredors) do |corredor|
  json.extract! corredor, :id, :marca, :modelo, :year, :version, :zona, :poliza, :cedula, :nombre, :apellido, :sexo, :estado, :fnacimiento, :tfijo, :tcelular, :informacion, :email, :nacion, :dia, :mes, :anio, :cod1, :cod2, :ced, :telefono, :celular
  json.url corredor_url(corredor, format: :json)
end
