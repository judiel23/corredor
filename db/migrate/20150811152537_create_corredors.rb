class CreateCorredors < ActiveRecord::Migration
  def change
    create_table :corredors do |t|
      t.text :marca
      t.text :modelo
      t.text :year
      t.text :version
      t.text :zona
      t.text :poliza
      t.text :cedula
      t.text :nombre
      t.text :apellido
      t.text :sexo
      t.text :estado
      t.text :fnacimiento
      t.text :tfijo
      t.text :tcelular
      t.text :informacion
      t.text :email
      t.text :nacion
      t.text :dia
      t.text :mes
      t.text :anio
      t.text :cod1
      t.text :cod2
      t.text :ced
      t.text :telefono
      t.text :celular

      t.timestamps null: false
    end
  end
end
