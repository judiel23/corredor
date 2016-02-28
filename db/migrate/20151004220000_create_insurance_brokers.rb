class CreateInsuranceBrokers < ActiveRecord::Migration
  def change
    create_table :insurance_brokers do |t|
      t.references :users, index: true
      t.string :insurance
      t.string :intermediary_code
      t.string :plan_code, limit: 5
      t.string :plan_review, limit: 5
      t.string :discount_rate

      t.timestamps null: false
    end
  end
end
