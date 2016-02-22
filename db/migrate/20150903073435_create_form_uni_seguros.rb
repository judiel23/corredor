class CreateFormUniSeguros < ActiveRecord::Migration
  def change
    create_table :form_uni_seguros do |t|
      t.string :desnombre, limit: 100
      t.string :desapellido, limit: 100
      t.string :rif, limit: 9
      t.string :codarealocal, limit: 4
      t.string :numtelefonolocal, limit: 7
      t.string :codareacel, limit: 4
      t.string :numtelefcel, limit: 7
      t.datetime :fecnac
      t.string :codedocivil, limit: 1
      t.string :codsexo, limit: 1
      t.string :email, limit: 100
      t.string :codmarca, limit: 3
      t.string :codmodelo, limit: 4
      t.string :codversion, limit: 5
      t.integer :anoveh
      t.string :codinter, limit: 6
      t.string :codestado, limit: 3
      t.string :codplan, limit: 3
      t.string :revplan, limit: 3
      t.integer :porcdcto

      t.timestamps null: false
    end
  end
end
