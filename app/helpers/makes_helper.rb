module MakesHelper
  def options_for_vehicles_makes
    Make.all.map { |make| [make.make, make.code] }
  end
end
