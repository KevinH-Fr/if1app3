class CreateResultats < ActiveRecord::Migration[7.0]
  def change
    create_table :resultats do |t|
      t.string :event
      t.string :pilote
      t.integer :qualification
      t.integer :course

      t.timestamps
    end
  end
end
