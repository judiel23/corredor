class CreateVersions < ActiveRecord::Migration
  def change
    create_table :versions do |t|
      t.string :make
      t.string :model
      t.string :code
      t.string :version
      t.string :descmotor
      t.string :desctransmision, limit: 5

      t.timestamps null: false
    end
  end
end
