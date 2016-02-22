module FormUniSegurosHelper
  def options_for_nacionalidad
    [
      ["Venezolana", "V"],
      ["Extranjero", "E"],
      ["Jurídico",   "J"],
      ["Gobierno",   "G"]
    ]
  end
  
  def options_for_marital_state
    [
      ["Casado(a)",     "C"],
      ["Divorsiado(a)", "D"],
      ["Soltero(a)",    "S"]
    ]
  end
  
  def options_for_sex
    [
      ["Femenino",  "F"],
      ["Masculino", "M"]
    ]
  end
  
  def options_for_vehicle_year
    ["2006", "2007", "2008", "2009", "2010", "2011", "2012", "2013","2014","2015"]
  end
end
