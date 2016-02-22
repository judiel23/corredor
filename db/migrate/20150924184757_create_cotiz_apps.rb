class CreateCotizApps < ActiveRecord::Migration
  def change
    create_table :cotiz_apps do |t|
      t.string :name
      t.string :lastname
      t.string :dni_type
      t.string :dni_number
      t.string :local_code_area
      t.string :local_phone
      t.string :movil_code_area
      t.string :movil_phone
      t.datetime :birthday
      t.string :marital_status, limit: 1
      t.string :sex, limit: 1
      t.string :email
      t.string :vehicle_year, limit: 4
      t.string :vehicle_brand
      t.string :vehicle_model
      t.string :vehicle_version
      t.string :plaque
      t.string :intermediate_code, limit: 6
      t.string :state
      t.string :plan_code
      t.string :plan_review
      t.string :discount_rate
      t.string :vehicle_use
      t.string :kilometer_zero, limit: 1
      t.string :vehicle_type

      t.timestamps null: false
    end
  end
end
