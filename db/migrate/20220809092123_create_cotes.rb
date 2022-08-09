class CreateCotes < ActiveRecord::Migration[7.0]
  def change
    create_table :cotes do |t|
      t.decimal :coteVictoire
      t.decimal :cotePodium
      t.decimal :coteTop10

      t.timestamps
    end
  end
end
