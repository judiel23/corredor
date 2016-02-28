class CreateMakes < ActiveRecord::Migration
  def change
    create_table :makes do |t|
      t.string :code
      t.string :make

      t.timestamps null: false
    end
  end
end
