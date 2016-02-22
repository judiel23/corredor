json.array!(@insurance_brokers) do |insurance_broker|
  json.extract! insurance_broker, :id, :users_id, :insurance, :intermediary_code, :plan_code, :plan_review, :discount_rate
  json.url insurance_broker_url(insurance_broker, format: :json)
end
