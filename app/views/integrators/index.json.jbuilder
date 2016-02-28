json.array!(@integrators) do |integrator|
  json.extract! integrator, :id
  json.url integrator_url(integrator, format: :json)
end
