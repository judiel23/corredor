json.array!(@form_uni_seguros) do |form_uni_seguro|
  json.extract! form_uni_seguro, :id, :desnombre, :desapellido, :rif, :codarealocal, :numtelefonolocal, :codareacel, :numtelefcel, :fecnac, :codedocivil, :codsexo, :email, :codmarca, :codmodelo, :codversion, :anoveh, :codinter, :codestado, :codplan, :revplan, :porcdcto
  json.url form_uni_seguro_url(form_uni_seguro, format: :json)
end
