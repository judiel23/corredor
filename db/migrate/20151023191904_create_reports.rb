class CreateReports < ActiveRecord::Migration
    def change
        create_table :reports do |t|
            t.string :insurance
            t.string :status
            t.references :corredor,  index: true, foreign_key: false
            t.decimal :cobertura, null: true, precision: 20, scale:2, default: nil
            t.decimal :eventos, null: true, precision: 20, scale:2, default: nil
            t.decimal :aire, null: true, precision: 20, scale:2, default: nil
            t.decimal :radio, null: true, precision: 20, scale:2, default: nil
            t.decimal :responsabilidad, null: true, precision: 20, scale:2, default: nil
            t.decimal :muerte, null: true, precision: 20, scale:2, default: nil
            t.decimal :invalidez, null: true, precision: 20, scale:2, default: nil
            t.decimal :curacion, null: true, precision: 20, scale:2, default: nil
            t.decimal :entierro, null: true, precision: 20, scale:2, default: nil
            t.decimal :cosa_dan, null: true, precision: 20, scale:2, default: nil
            t.decimal :personas_dan, null: true, precision: 20, scale:2, default: nil
            t.decimal :exceso_cosa, null: true, precision: 20, scale:2, default: nil
            t.decimal :exceso_persona, null: true, precision: 20, scale:2, default: nil
            t.decimal :asistencia, null: true, precision: 20, scale:2, default: nil
            t.decimal :prima, null: true, precision: 20, scale:2, default: nil
            t.timestamps null: false
        end
    end
end
