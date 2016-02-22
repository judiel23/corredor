json.array!(@cotiz_apps) do |cotiz_app|
  json.extract! cotiz_app, :id, :name, :lastname, :dni_type, :dni_number, :local_code_area, :local_phone, :movil_code_area, :movil_phone, :birthday, :marital_status, :sex, :email, :vehicle_year, :vehicle_brand, :vehicle_model, :vehicle_version, :intermediate_code, :state, :plan_code, :plan_review, :discount_rate, :vehicle_use, :kilometer_zero, :vehicle_type
  json.url cotiz_app_url(cotiz_app, format: :json)
end
