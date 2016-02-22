module VehiclesHelper
  def options_for_vehicles_models(make)
    Vehicle.where(:make => make).map { |model| [model.model, model.code] } if make.present?
  end
end
