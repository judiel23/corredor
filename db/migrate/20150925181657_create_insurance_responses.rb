class CreateInsuranceResponses < ActiveRecord::Migration
  def change
    create_table :insurance_responses do |t|
      t.string :insurance
      t.references :cotiz_app, index: true, foreign_key: false
      t.references :corredor,  index: true, foreign_key: false
      t.text :response

      t.timestamps null: false
    end
  end
end
